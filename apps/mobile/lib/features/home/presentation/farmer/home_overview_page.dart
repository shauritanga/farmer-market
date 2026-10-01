import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/app/router/app_router.dart';
import 'package:fama/core/widgets/app_empty_state.dart';
import 'package:fama/core/widgets/app_error_state.dart';
import 'package:fama/core/widgets/app_loading.dart';
import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/authentication/presentation/state/auth_state.dart';
import 'package:fama/features/buyers/presentation/widgets/buyer_demands_home_section.dart';
import 'package:fama/features/inputs/presentation/widgets/inputs_home_section.dart';
import 'package:fama/features/market_prices/presentation/providers/market_prices_provider.dart';
import 'package:fama/features/market_prices/presentation/widgets/market_price_card.dart';
import 'package:fama/l10n/app_localizations.dart';

/// The "Home" tab of [FarmerHomeShell]: a greeting, a search entry point,
/// and the top 10 products in Tanzania's most-active market (derived from
/// data, see MarketPricesService.findTopMarket — never hardcoded) — prices
/// are the primary thing a farmer checks first, per
/// docs/product/product-spec.md.
class HomeOverviewPage extends ConsumerWidget {
  const HomeOverviewPage({super.key, required this.onNavigateToTab});

  final void Function(int tabIndex) onNavigateToTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final authState = ref.watch(authNotifierProvider);
    final name = authState is AuthAuthenticated ? authState.user.name : '';
    final topMarketAsync = ref.watch(topMarketPricesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            icon: HugeIcon(icon: HugeIcons.strokeRoundedSearch01, size: 22.sp),
            onPressed: () => context.push(marketSearchPath),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(topMarketPricesProvider.future),
        child: topMarketAsync.when(
          loading: () => const AppLoading(),
          error: (error, _) => ListView(
            children: [
              SizedBox(height: 80.h),
              AppErrorState(
                message: l10n.marketPricesLoadError,
                onRetry: () => ref.invalidate(topMarketPricesProvider),
              ),
            ],
          ),
          data: (top) {
            return ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                Text(
                  l10n.homeWelcomeTitle(name),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 16.h),
                if (top.marketName != null)
                  Text(
                    l10n.homeTopMarketTitle(
                      '${top.marketName}, ${top.marketRegion}',
                    ),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                SizedBox(height: 12.h),
                if (top.prices.isEmpty)
                  AppEmptyState(message: l10n.marketPricesEmpty)
                else ...[
                  for (final price in top.prices)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: MarketPriceCard(price: price, showMarket: false),
                    ),
                  Center(
                    child: TextButton(
                      onPressed: () => onNavigateToTab(1),
                      child: Text(l10n.navMarket),
                    ),
                  ),
                ],
                const BuyerDemandsHomeSection(),
                const InputsHomeSection(),
                SizedBox(height: 16.h),
              ],
            );
          },
        ),
      ),
    );
  }
}
