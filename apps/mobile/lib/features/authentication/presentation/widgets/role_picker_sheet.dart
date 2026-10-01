import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/features/authentication/domain/entities/user_role.dart';
import 'package:fama/features/authentication/presentation/widgets/role_display.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Pure picker — presents the three roles as a list, returns the tapped one
/// via `Navigator.pop`. Does not submit anything itself; the calling page
/// (RegisterRolePage) owns the actual "create account" action.
class RolePickerSheet extends StatelessWidget {
  const RolePickerSheet({super.key, required this.selected});

  final UserRole? selected;

  static Future<UserRole?> show(BuildContext context, {UserRole? selected}) {
    return showModalBottomSheet<UserRole>(
      context: context,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (context) => RolePickerSheet(selected: selected),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  l10n.roleSheetTitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SizedBox(height: 12.h),
            for (final role in UserRole.values)
              ListTile(
                onTap: () => Navigator.pop(context, role),
                leading: HugeIcon(
                  icon: iconForRole(role),
                  size: 22.sp,
                  color: colorScheme.onSurfaceVariant,
                ),
                title: Text(labelForRole(role, l10n)),
                trailing: role == selected
                    ? HugeIcon(
                        icon: HugeIcons.strokeRoundedTick01,
                        size: 20.sp,
                        color: colorScheme.primary,
                      )
                    : null,
              ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }
}
