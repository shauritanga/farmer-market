import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/features/buyers/presentation/providers/buyer_demand_provider.dart';
import 'package:fama/features/buyers/presentation/widgets/buyer_demand_card.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Home tab preview: the newest buyer requests (up to 3) with a link to
/// the full list. Stays quiet while loading or when there is no demand
/// yet — the market section above is the primary content.
class BuyerDemandsHomeSection extends ConsumerWidget {
  const BuyerDemandsHomeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final demandsAsync = ref.watch(openBuyerDemandsProvider);

    return demandsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (error, _) => const SizedBox.shrink(),
      data: (demands) {
        if (demands.isEmpty) return const SizedBox.shrink();
        final preview = demands.take(3).toList();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              l10n.buyerDemandsSectionTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 12.h),
            for (final demand in preview)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: BuyerDemandCard(demand: demand),
              ),
            Center(
              child: TextButton(
                onPressed: () => context.push(buyerDemandsPath),
                child: Text(l10n.buyerDemandsViewAll),
              ),
            ),
          ],
        );
      },
    );
  }
}
