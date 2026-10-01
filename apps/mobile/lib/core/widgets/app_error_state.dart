import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/core/widgets/app_button.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Standard error state with an optional retry action. Every important
/// async screen must define this — see AGENTS.md §12 UX rules.
class AppErrorState extends StatelessWidget {
  const AppErrorState({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(
              icon: HugeIcons.strokeRoundedAlert01,
              size: 32.sp,
              color: Theme.of(context).colorScheme.error,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              SizedBox(height: 16.h),
              AppButton(
                label: AppLocalizations.of(context)!.commonRetry,
                onPressed: onRetry,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
