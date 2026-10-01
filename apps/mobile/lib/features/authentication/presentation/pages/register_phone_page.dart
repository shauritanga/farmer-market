import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/core/widgets/app_text_field.dart';
import 'package:fama/features/authentication/presentation/providers/registration_flow_provider.dart';
import 'package:fama/features/authentication/presentation/widgets/registration_step_scaffold.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Step 2 of registration: phone number, then request a verification code.
class RegisterPhonePage extends ConsumerStatefulWidget {
  const RegisterPhonePage({super.key});

  @override
  ConsumerState<RegisterPhonePage> createState() => _RegisterPhonePageState();
}

class _RegisterPhonePageState extends ConsumerState<RegisterPhonePage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final ok = await ref
        .read(registrationFlowProvider.notifier)
        .sendCode(_phoneController.text.trim());
    if (ok && mounted) context.push(registerVerifyPath);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final flow = ref.watch(registrationFlowProvider);

    return Form(
      key: _formKey,
      child: RegistrationStepScaffold(
        title: l10n.registerPhoneTitle,
        subtitle: l10n.registerPhoneSubtitle,
        field: AppTextField(
          controller: _phoneController,
          label: l10n.loginPhoneLabel,
          hintText: l10n.phoneHint,
          icon: HugeIcons.strokeRoundedSmartPhone01,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.done,
          autofocus: true,
          onFieldSubmitted: (_) => _submit(),
          validator: (value) => (value == null || value.trim().isEmpty)
              ? l10n.loginPhoneRequired
              : null,
        ),
        buttonLabel: l10n.registerSendCodeButton,
        isLoading: flow.isLoading,
        errorMessage: flow.error?.message,
        onSubmit: _submit,
      ),
    );
  }
}
