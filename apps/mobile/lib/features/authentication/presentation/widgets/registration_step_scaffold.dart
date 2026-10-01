import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/core/widgets/app_button.dart';

/// Shared layout for every step of the name -> phone -> code -> password
/// registration wizard: back arrow, title, subtitle, one field, one
/// full-width primary button. Keeps the four step pages consistent without
/// each re-implementing the same scaffold.
class RegistrationStepScaffold extends StatelessWidget {
  const RegistrationStepScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.field,
    required this.buttonLabel,
    required this.isLoading,
    required this.onSubmit,
    this.errorMessage,
  });

  final String title;
  final String subtitle;
  final Widget field;
  final String buttonLabel;
  final bool isLoading;
  final VoidCallback onSubmit;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01, size: 22.sp),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineSmall),
              SizedBox(height: 8.h),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              SizedBox(height: 24.h),
              field,
              if (errorMessage != null) ...[
                SizedBox(height: 12.h),
                Text(
                  errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: AppButton(
                  label: buttonLabel,
                  isLoading: isLoading,
                  onPressed: onSubmit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
