import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/core/constants/app_colors.dart';
import 'package:fama/core/widgets/app_text_field.dart';
import 'package:fama/features/authentication/data/services/sms_code_service.dart';
import 'package:fama/features/authentication/presentation/providers/registration_flow_provider.dart';
import 'package:fama/features/authentication/presentation/widgets/registration_step_scaffold.dart';
import 'package:fama/l10n/app_localizations.dart';

const _resendCooldownSeconds = 60;

/// Step 3 of registration: enter the code sent to the phone from step 2.
/// Auto-fills from an incoming SMS (Android SMS User Consent API — no
/// READ_SMS permission needed) and offers a 60s-gated resend, matching the
/// sibling RealMoney borrower app's registration screen.
class RegisterVerifyCodePage extends ConsumerStatefulWidget {
  const RegisterVerifyCodePage({super.key});

  @override
  ConsumerState<RegisterVerifyCodePage> createState() =>
      _RegisterVerifyCodePageState();
}

class _RegisterVerifyCodePageState
    extends ConsumerState<RegisterVerifyCodePage> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();
  final _sms = SmsCodeService();

  Timer? _timer;
  int _resendSeconds = _resendCooldownSeconds;
  int _smsSession = 0;

  @override
  void initState() {
    super.initState();
    _startResendTimer();
    unawaited(_listenForSms(_smsSession));
  }

  @override
  void dispose() {
    _timer?.cancel();
    _codeController.dispose();
    _smsSession++;
    unawaited(_sms.stop());
    super.dispose();
  }

  void _startResendTimer() {
    _timer?.cancel();
    setState(() => _resendSeconds = _resendCooldownSeconds);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _resendSeconds <= 1) {
        timer.cancel();
        if (mounted) setState(() => _resendSeconds = 0);
        return;
      }
      setState(() => _resendSeconds--);
    });
  }

  Future<void> _listenForSms(int session) async {
    try {
      final code = await _sms.listen();
      if (!mounted || session != _smsSession || code == null) return;
      if (_codeController.text.isEmpty) {
        setState(() => _codeController.text = code);
      }
    } catch (_) {
      // Manual entry remains available regardless.
    }
  }

  Future<void> _resend() async {
    final flow = ref.read(registrationFlowProvider);
    final ok = await ref
        .read(registrationFlowProvider.notifier)
        .sendCode(flow.phoneNumber);
    if (!mounted || !ok) return;
    _codeController.clear();
    _startResendTimer();
    _smsSession++;
    unawaited(_listenForSms(_smsSession));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _smsSession++;
    unawaited(_sms.stop());
    final ok = await ref
        .read(registrationFlowProvider.notifier)
        .verifyCode(_codeController.text.trim());
    if (ok && mounted) context.push(registerPasswordPath);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final flow = ref.watch(registrationFlowProvider);

    return Form(
      key: _formKey,
      child: RegistrationStepScaffold(
        title: l10n.registerCodeTitle,
        subtitle: l10n.registerCodeSubtitle(flow.phoneNumber),
        field: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              controller: _codeController,
              label: l10n.registerCodeLabel,
              icon: HugeIcons.strokeRoundedSmsCode,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              autofocus: true,
              onFieldSubmitted: (_) => _submit(),
              validator: (value) => (value == null || value.trim().isEmpty)
                  ? l10n.registerCodeRequired
                  : null,
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _resendSeconds > 0 || flow.isLoading
                    ? null
                    : _resend,
                child: Text(
                  _resendSeconds > 0
                      ? l10n.registerResendIn(_resendSeconds)
                      : l10n.registerResendCode,
                ),
              ),
            ),
            if (flow.developmentCode != null) ...[
              SizedBox(height: 4.h),
              _DevCodeHint(
                message: l10n.registerDevCodeHint(flow.developmentCode!),
              ),
            ],
          ],
        ),
        buttonLabel: l10n.registerVerifyButton,
        isLoading: flow.isLoading,
        errorMessage: flow.error?.message,
        onSubmit: _submit,
      ),
    );
  }
}

/// No real SMS was sent — the backend handed the code straight back
/// because it's running with `ONBOARDING_DEV_MODE=true` (no Beem
/// credentials configured). Shown as a warning so it's unmistakably a
/// dev-only affordance, matching the sibling RealMoney borrower app.
class _DevCodeHint extends StatelessWidget {
  const _DevCodeHint({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.warningContainer,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          HugeIcon(
            icon: HugeIcons.strokeRoundedAlert02,
            size: 18.sp,
            color: AppColors.warning,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodySmall
                  ?.copyWith(color: AppColors.warning),
            ),
          ),
        ],
      ),
    );
  }
}
