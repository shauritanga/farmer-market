import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/core/widgets/app_text_field.dart';
import 'package:fama/features/authentication/presentation/providers/registration_flow_provider.dart';
import 'package:fama/features/authentication/presentation/widgets/registration_step_scaffold.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Step 1 of registration: full name only.
class RegisterNamePage extends ConsumerStatefulWidget {
  const RegisterNamePage({super.key});

  @override
  ConsumerState<RegisterNamePage> createState() => _RegisterNamePageState();
}

class _RegisterNamePageState extends ConsumerState<RegisterNamePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(registrationFlowProvider.notifier)
        .setFullName(_nameController.text.trim());
    context.push(registerPhonePath);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: RegistrationStepScaffold(
        title: l10n.registerNameTitle,
        subtitle: l10n.registerNameSubtitle,
        field: AppTextField(
          controller: _nameController,
          label: l10n.registerNameLabel,
          icon: HugeIcons.strokeRoundedUser02,
          textInputAction: TextInputAction.done,
          autofocus: true,
          onFieldSubmitted: (_) => _submit(),
          validator: (value) => (value == null || value.trim().isEmpty)
              ? l10n.registerNameRequired
              : null,
        ),
        buttonLabel: l10n.commonContinue,
        isLoading: false,
        onSubmit: _submit,
      ),
    );
  }
}
