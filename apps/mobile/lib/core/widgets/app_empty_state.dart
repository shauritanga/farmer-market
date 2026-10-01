import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

/// Standard empty state for lists/screens with no data yet.
class AppEmptyState extends StatelessWidget {
  const AppEmptyState({super.key, required this.message, this.icon});

  final String message;

  /// A hugeicons icon data list, e.g. `HugeIcons.strokeRoundedPackageOpen`.
  /// Defaults to a generic inbox icon.
  final List<List<dynamic>>? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HugeIcon(
              icon: icon ?? HugeIcons.strokeRoundedInbox,
              size: 32.sp,
              color: Theme.of(context).colorScheme.outline,
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
