import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:fama/core/utils/time_ago.dart';
import 'package:fama/core/widgets/app_empty_state.dart';
import 'package:fama/core/widgets/app_error_state.dart';
import 'package:fama/core/widgets/app_loading.dart';
import 'package:fama/core/widgets/status_badge.dart';
import 'package:fama/features/inputs/domain/entities/agro_input_order.dart';
import 'package:fama/features/inputs/presentation/providers/inputs_provider.dart';
import 'package:fama/l10n/app_localizations.dart';

/// The farmer's own input order requests and where each one stands:
/// REQUESTED until the supplier confirms, then CONFIRMED → DELIVERED.
class MyInputOrdersPage extends ConsumerWidget {
  const MyInputOrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final ordersAsync = ref.watch(myInputOrdersProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.inputsMyOrdersTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(myInputOrdersProvider.future),
        child: ordersAsync.when(
          loading: () => const AppLoading(),
          error: (error, _) => ListView(
            children: [
              SizedBox(height: 80.h),
              AppErrorState(
                message: l10n.inputsLoadError,
                onRetry: () => ref.invalidate(myInputOrdersProvider),
              ),
            ],
          ),
          data: (orders) {
            if (orders.isEmpty) {
              return ListView(
                children: [
                  SizedBox(height: 80.h),
                  AppEmptyState(message: l10n.inputsMyOrdersEmpty),
                ],
              );
            }
            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: orders.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) =>
                  _InputOrderCard(order: orders[index]),
            );
          },
        ),
      ),
    );
  }
}

class _InputOrderCard extends StatelessWidget {
  const _InputOrderCard({required this.order});

  final AgroInputOrder order;

  StatusTone get _tone => switch (order.status) {
    'CONFIRMED' || 'DELIVERED' => StatusTone.success,
    'CANCELLED' => StatusTone.error,
    _ => StatusTone.pending,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                  child: Text(order.inputName, style: textTheme.titleMedium),
                ),
                StatusBadge(label: order.status, tone: _tone),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              '${order.quantity.toStringAsFixed(0)} ${order.unit} · TZS ${order.totalPrice.toStringAsFixed(0)}',
              style: textTheme.headlineSmall,
            ),
            SizedBox(height: 4.h),
            Text(
              formatUpdatedAgo(order.createdAt, l10n),
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              DateFormat.yMMMd().format(order.createdAt.toLocal()),
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
