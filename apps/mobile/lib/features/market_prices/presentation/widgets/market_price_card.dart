import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:fama/core/utils/time_ago.dart';
import 'package:fama/core/widgets/status_badge.dart';
import 'package:fama/features/market_prices/domain/entities/market_price.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Shared by the Market tab (full list, every market) and the Home tab's
/// top-market preview and the search results — one card design for a
/// price everywhere it appears.
class MarketPriceCard extends StatelessWidget {
  const MarketPriceCard({
    super.key,
    required this.price,
    this.showMarket = true,
  });

  final MarketPrice price;

  /// Set false when every card in the list is already known to be from
  /// the same market (e.g. the Home tab's "top market" section) so the
  /// market name isn't repeated on every row.
  final bool showMarket;

  StatusTone get _tone => switch (price.priceType) {
    'COMPLETED_TRANSACTION' => StatusTone.success,
    'BUYER_OFFER' => StatusTone.pending,
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
                    price.grade == null
                        ? price.commodityName
                        : '${price.commodityName} — ${price.grade}',
                    style: textTheme.titleMedium,
                  ),
                ),
                StatusBadge(label: price.priceType, tone: _tone),
              ],
            ),
            if (showMarket) ...[
              SizedBox(height: 4.h),
              Text(
                '${price.marketName}, ${price.marketRegion}',
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            SizedBox(height: 12.h),
            Text(
              '${price.currency} ${price.price.toStringAsFixed(0)} / ${price.unit}',
              style: textTheme.headlineSmall,
            ),
            SizedBox(height: 4.h),
            Text(
              formatUpdatedAgo(price.recordedAt, l10n),
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            Text(
              DateFormat.yMMMd().add_Hm().format(price.recordedAt.toLocal()),
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
