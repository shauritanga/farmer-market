import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/core/widgets/app_button.dart';
import 'package:fama/core/widgets/app_text_field.dart';
import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/authentication/presentation/state/auth_state.dart';
import 'package:fama/l10n/app_localizations.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(authNotifierProvider.notifier)
        .login(
          phoneNumber: _phoneController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(next.failure.message)));
      }
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedGlobe02, size: 22.sp),
            onPressed: () => context.push(settingsPath),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.loginTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 24.h),
                AppTextField(
                  controller: _phoneController,
                  label: l10n.loginPhoneLabel,
                  hintText: l10n.phoneHint,
                  icon: HugeIcons.strokeRoundedSmartPhone01,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? l10n.loginPhoneRequired
                      : null,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: _passwordController,
                  label: l10n.loginPasswordLabel,
                  icon: HugeIcons.strokeRoundedLockPassword,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  validator: (value) => (value == null || value.isEmpty)
                      ? l10n.loginPasswordRequired
                      : null,
                ),
                SizedBox(height: 24.h),
                AppButton(
                  label: l10n.loginSignInButton,
                  isLoading: isLoading,
                  onPressed: _submit,
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l10n.loginNoAccount),
                    TextButton(
                      onPressed: () => context.push(registerNamePath),
                      child: Text(l10n.loginRegisterLink),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
