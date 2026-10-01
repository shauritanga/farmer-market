import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:fama/core/utils/time_ago.dart';
import 'package:fama/features/buyers/domain/entities/buyer_demand.dart';
import 'package:fama/l10n/app_localizations.dart';

/// One open buyer request, as a farmer browses demand: what the buyer
/// wants, how much, where, by when, and at what offer price.
class BuyerDemandCard extends StatelessWidget {
  const BuyerDemandCard({super.key, required this.demand});

  final BuyerDemand demand;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final buyer = demand.displayBuyer;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              demand.grade == null
                  ? demand.commodityName
                  : '${demand.commodityName} — ${demand.grade}',
              style: textTheme.titleMedium,
            ),
            SizedBox(height: 4.h),
            Text(
              buyer == null
                  ? demand.targetLocation
                  : '$buyer · ${demand.targetLocation}',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              '${demand.quantity.toStringAsFixed(0)} ${demand.unit}',
              style: textTheme.headlineSmall,
            ),
            if (demand.offerPrice != null) ...[
              SizedBox(height: 4.h),
              Text(
                'TZS ${demand.offerPrice!.toStringAsFixed(0)} / ${demand.unit}',
                style: textTheme.bodyMedium,
              ),
            ],
            SizedBox(height: 4.h),
            Text(
              l10n.buyerRequiredBy(
                DateFormat.yMMMd().format(demand.requiredBy.toLocal()),
              ),
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            if (demand.paymentTerms != null)
              Text(
                l10n.buyerPaymentTerms(demand.paymentTerms!),
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            Text(
              formatUpdatedAgo(demand.createdAt, l10n),
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
