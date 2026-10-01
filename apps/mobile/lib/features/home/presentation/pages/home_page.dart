import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/features/authentication/domain/entities/user_role.dart';
import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/authentication/presentation/state/auth_state.dart';
import 'package:fama/features/authentication/presentation/widgets/role_display.dart';
import 'package:fama/features/home/presentation/farmer/farmer_home_shell.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Landing screen once authenticated. Farmers get the full bottom-nav
/// shell ([FarmerHomeShell]); Buyer/Transporter still get a plain greeting
/// screen — their own shells aren't built yet, see
/// docs/architecture/architecture.md "Main Features".
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  String _roleMessage(UserRole role, AppLocalizations l10n) => switch (role) {
    UserRole.farmer => l10n.homeRoleFarmerMessage,
    UserRole.buyer => l10n.homeRoleBuyerMessage,
    UserRole.transporter => l10n.homeRoleTransporterMessage,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authNotifierProvider);

    if (authState is! AuthAuthenticated) {
      // Redirect handles this; avoids a null-user crash for one frame
      // while it does.
      return const Scaffold(body: SizedBox.shrink());
    }

    final user = authState.user;

    if (user.role == UserRole.farmer) {
      return const FarmerHomeShell();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedGlobe02, size: 22.sp),
            onPressed: () => context.push(settingsPath),
          ),
          IconButton(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedLogout01, size: 22.sp),
            onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HugeIcon(
              icon: iconForRole(user.role),
              size: 40.sp,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 16.h),
            Text(
              l10n.homeWelcomeTitle(user.name),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 8.h),
            Text(
              _roleMessage(user.role, l10n),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
