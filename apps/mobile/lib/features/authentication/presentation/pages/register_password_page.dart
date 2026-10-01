import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/core/widgets/app_text_field.dart';
import 'package:fama/features/authentication/presentation/providers/registration_flow_provider.dart';
import 'package:fama/features/authentication/presentation/widgets/registration_step_scaffold.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Step 4 of registration: password. Just collects it and moves on — the
/// role step (step 5) is the one that actually calls `register`.
class RegisterPasswordPage extends ConsumerStatefulWidget {
  const RegisterPasswordPage({super.key});

  @override
  ConsumerState<RegisterPasswordPage> createState() =>
      _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends ConsumerState<RegisterPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(registrationFlowProvider.notifier)
        .setPassword(_passwordController.text);
    context.push(registerRolePath);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Form(
      key: _formKey,
      child: RegistrationStepScaffold(
        title: l10n.registerPasswordTitle,
        subtitle: l10n.registerPasswordSubtitle,
        field: AppTextField(
          controller: _passwordController,
          label: l10n.loginPasswordLabel,
          icon: HugeIcons.strokeRoundedLockPassword,
          obscureText: true,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _submit(),
          validator: (value) => (value == null || value.length < 8)
              ? l10n.registerPasswordMinLength
              : null,
        ),
        buttonLabel: l10n.registerContinueButton,
        isLoading: false,
        onSubmit: _submit,
      ),
    );
  }
}
