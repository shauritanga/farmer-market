import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';

import 'package:fama/core/widgets/app_empty_state.dart';
import 'package:fama/core/widgets/app_error_state.dart';
import 'package:fama/core/widgets/app_loading.dart';
import 'package:fama/features/notifications/domain/entities/app_notification.dart';
import 'package:fama/features/notifications/presentation/providers/notifications_provider.dart';
import 'package:fama/l10n/app_localizations.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final notificationsAsync = ref.watch(myNotificationsProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01, size: 22.sp),
          onPressed: () => context.pop(),
        ),
        title: Text(l10n.notificationsTitle),
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(myNotificationsProvider.future),
        child: notificationsAsync.when(
          loading: () => const AppLoading(),
          error: (error, _) => ListView(
            children: [
              SizedBox(height: 80.h),
              AppErrorState(
                message: l10n.notificationsLoadError,
                onRetry: () => ref.invalidate(myNotificationsProvider),
              ),
            ],
          ),
          data: (notifications) {
            if (notifications.isEmpty) {
              return ListView(
                children: [
                  SizedBox(height: 80.h),
                  AppEmptyState(
                    message: l10n.notificationsEmpty,
                    icon: HugeIcons.strokeRoundedNotification01,
                  ),
                ],
              );
            }
            return ListView.separated(
              itemCount: notifications.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) =>
                  _NotificationTile(notification: notifications[index]),
            );
          },
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      leading: HugeIcon(
        icon: HugeIcons.strokeRoundedNotification01,
        color: notification.isRead
            ? colorScheme.onSurfaceVariant
            : colorScheme.primary,
      ),
      title: Text(
        notification.title,
        style: textTheme.titleSmall?.copyWith(
          fontWeight: notification.isRead ? FontWeight.w400 : FontWeight.w700,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(notification.body),
          SizedBox(height: 4.h),
          Text(
            DateFormat.yMMMd().add_Hm().format(
              notification.createdAt.toLocal(),
            ),
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      isThreeLine: true,
    );
  }
}
