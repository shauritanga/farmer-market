import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/core/widgets/app_button.dart';
import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/authentication/presentation/state/auth_state.dart';
import 'package:fama/l10n/app_localizations.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authNotifierProvider);
    final user = authState is AuthAuthenticated ? authState.user : null;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.navMore)),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (user != null)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 24.r,
                        backgroundColor: colorScheme.primaryContainer,
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedUser02,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              user.phoneNumber,
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(height: 16.h),
            _MoreRow(
              icon: HugeIcons.strokeRoundedNotification01,
              label: l10n.moreNotifications,
              onTap: () => context.push(notificationsPath),
            ),
            _MoreRow(
              icon: HugeIcons.strokeRoundedUserGroup,
              label: l10n.moreBuyerDemands,
              onTap: () => context.push(buyerDemandsPath),
            ),
            _MoreRow(
              icon: HugeIcons.strokeRoundedShoppingBag01,
              label: l10n.moreInputs,
              onTap: () => context.push(inputsPath),
            ),
            _MoreRow(
              icon: HugeIcons.strokeRoundedGlobe02,
              label: l10n.settingsTitle,
              onTap: () => context.push(settingsPath),
            ),
            const Spacer(),
            AppButton(
              label: l10n.homeSignOutButton,
              onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
            ),
          ],
        ),
      ),
    );
  }
}

class _MoreRow extends StatelessWidget {
  const _MoreRow({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final List<List<dynamic>> icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: HugeIcon(
        icon: icon,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      title: Text(label),
      trailing: HugeIcon(
        icon: HugeIcons.strokeRoundedArrowRight01,
        size: 18.sp,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}
