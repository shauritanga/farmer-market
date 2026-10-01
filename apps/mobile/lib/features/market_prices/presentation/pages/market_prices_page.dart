import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fama/core/widgets/app_empty_state.dart';
import 'package:fama/core/widgets/app_error_state.dart';
import 'package:fama/core/widgets/app_loading.dart';
import 'package:fama/features/market_prices/presentation/providers/market_prices_provider.dart';
import 'package:fama/features/market_prices/presentation/widgets/market_price_card.dart';
import 'package:fama/l10n/app_localizations.dart';

class MarketPricesPage extends ConsumerWidget {
  const MarketPricesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final pricesAsync = ref.watch(marketPricesProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.marketPricesTitle)),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(marketPricesProvider.future),
        child: pricesAsync.when(
          loading: () => const AppLoading(),
          error: (error, _) => ListView(
            children: [
              SizedBox(height: 80.h),
              AppErrorState(
                message: l10n.marketPricesLoadError,
                onRetry: () => ref.invalidate(marketPricesProvider),
              ),
            ],
          ),
          data: (prices) {
            if (prices.isEmpty) {
              return ListView(
                children: [
                  SizedBox(height: 80.h),
                  AppEmptyState(message: l10n.marketPricesEmpty),
                ],
              );
            }
            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              itemCount: prices.length,
              separatorBuilder: (_, _) => SizedBox(height: 8.h),
              itemBuilder: (context, index) =>
                  MarketPriceCard(price: prices[index]),
            );
          },
        ),
      ),
    );
  }
}
