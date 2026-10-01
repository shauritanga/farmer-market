import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/features/authentication/domain/entities/user_role.dart';
import 'package:fama/features/authentication/presentation/widgets/role_display.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Looks like [AppTextField] (same label/icon/border styling) but is
/// read-only and opens [RolePickerSheet] on tap instead of a keyboard —
/// the role is chosen from a bottom sheet, not typed.
class RoleField extends StatelessWidget {
  const RoleField({
    super.key,
    required this.role,
    required this.onTap,
    this.errorText,
  });

  final UserRole? role;
  final VoidCallback onTap;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: l10n.roleSheetLabel,
          errorText: errorText,
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: HugeIcon(
              icon: role == null
                  ? HugeIcons.strokeRoundedUser02
                  : iconForRole(role!),
              size: 20.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 44.w,
            minHeight: 20.h,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: HugeIcon(
              icon: HugeIcons.strokeRoundedArrowDown01,
              size: 20.sp,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        child: Text(
          role == null ? '' : labelForRole(role!, l10n),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
