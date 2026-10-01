import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:fama/core/widgets/app_empty_state.dart';
import 'package:fama/core/widgets/app_error_state.dart';
import 'package:fama/core/widgets/app_loading.dart';
import 'package:fama/core/widgets/status_badge.dart';
import 'package:fama/features/orders/domain/entities/order.dart';
import 'package:fama/features/orders/presentation/providers/orders_provider.dart';
import 'package:fama/l10n/app_localizations.dart';

class MyOrdersPage extends ConsumerWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ordersAsync = ref.watch(myOrdersProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myOrdersTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(myOrdersProvider.future),
        child: ordersAsync.when(
          loading: () => const AppLoading(),
          error: (error, _) => ListView(
            children: [
              SizedBox(height: 80.h),
              AppErrorState(
                message: l10n.myOrdersLoadError,
                onRetry: () => ref.invalidate(myOrdersProvider),
              ),
            ],
          ),
          data: (orders) {
            if (orders.isEmpty) {
              return ListView(
                children: [
                  SizedBox(height: 80.h),
                  AppEmptyState(message: l10n.myOrdersEmpty),
                ],
              );
            }
            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: orders.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) => _OrderCard(order: orders[index]),
            );
          },
        ),
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});

  final Order order;

  StatusTone get _tone => switch (order.status) {
    'DELIVERED' || 'VERIFIED' || 'PAID' || 'COMPLETED' => StatusTone.success,
    'CANCELLED' => StatusTone.error,
    _ => StatusTone.pending,
  };

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    order.commodityName,
                    style: textTheme.titleMedium,
                  ),
                ),
                StatusBadge(label: order.status, tone: _tone),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              '${order.pickupLocation} → ${order.deliveryLocation}',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '${order.quantity.toStringAsFixed(0)} ${order.unit} · TZS ${order.price.toStringAsFixed(0)}',
              style: textTheme.headlineSmall,
            ),
            SizedBox(height: 4.h),
            Text(
              DateFormat.yMMMd().add_Hm().format(order.createdAt.toLocal()),
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
