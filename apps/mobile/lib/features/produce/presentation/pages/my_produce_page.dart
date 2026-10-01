import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:fama/core/widgets/app_empty_state.dart';
import 'package:fama/core/widgets/app_error_state.dart';
import 'package:fama/core/widgets/app_loading.dart';
import 'package:fama/core/widgets/status_badge.dart';
import 'package:fama/features/produce/domain/entities/produce_listing.dart';
import 'package:fama/features/produce/presentation/providers/produce_provider.dart';
import 'package:fama/l10n/app_localizations.dart';

class MyProducePage extends ConsumerWidget {
  const MyProducePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final listingsAsync = ref.watch(myProduceListingsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.myProduceTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(myProduceListingsProvider.future),
        child: listingsAsync.when(
          loading: () => const AppLoading(),
          error: (error, _) => ListView(
            children: [
              SizedBox(height: 80.h),
              AppErrorState(
                message: l10n.myProduceLoadError,
                onRetry: () => ref.invalidate(myProduceListingsProvider),
              ),
            ],
          ),
          data: (listings) {
            if (listings.isEmpty) {
              return ListView(
                children: [
                  SizedBox(height: 80.h),
                  AppEmptyState(message: l10n.myProduceEmpty),
                ],
              );
            }
            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: listings.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) =>
                  _ProduceListingCard(listing: listings[index]),
            );
          },
        ),
      ),
    );
  }
}

class _ProduceListingCard extends StatelessWidget {
  const _ProduceListingCard({required this.listing});

  final ProduceListing listing;

  StatusTone get _tone => switch (listing.status) {
    'ACTIVE' => StatusTone.success,
    'PAUSED' => StatusTone.pending,
    'CLOSED' => StatusTone.error,
    _ => StatusTone.neutral,
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
                  child: Text(
                    listing.grade == null
                        ? listing.commodityName
                        : '${listing.commodityName} — ${listing.grade}',
                    style: textTheme.titleMedium,
                  ),
                ),
                StatusBadge(label: listing.status, tone: _tone),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              listing.location,
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '${listing.quantityAvailable.toStringAsFixed(0)} ${listing.unit}',
              style: textTheme.headlineSmall,
            ),
            SizedBox(height: 4.h),
            Text(
              listing.expectedPrice == null
                  ? (listing.isNegotiable ? l10n.produceNegotiable : '—')
                  : 'TZS ${listing.expectedPrice!.toStringAsFixed(0)} / ${listing.unit}',
              style: textTheme.bodyMedium,
            ),
            SizedBox(height: 4.h),
            Text(
              DateFormat.yMMMd().format(listing.availableFrom.toLocal()),
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
