import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:fama/core/widgets/app_empty_state.dart';
import 'package:fama/core/widgets/app_error_state.dart';
import 'package:fama/core/widgets/app_loading.dart';
import 'package:fama/features/market_prices/presentation/providers/market_prices_provider.dart';
import 'package:fama/features/market_prices/presentation/widgets/market_price_card.dart';
import 'package:fama/l10n/app_localizations.dart';

/// Filters the same "current prices" list the Market tab shows, by
/// commodity name, client-side — the list is already capped at 50 latest
/// records, so this is cheap. Move to a server-side `?q=` search if the
/// dataset grows enough to make that no longer true.
class MarketSearchPage extends ConsumerStatefulWidget {
  const MarketSearchPage({super.key});

  @override
  ConsumerState<MarketSearchPage> createState() => _MarketSearchPageState();
}

class _MarketSearchPageState extends ConsumerState<MarketSearchPage> {
  final _controller = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pricesAsync = ref.watch(marketPricesProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: HugeIcon(icon: HugeIcons.strokeRoundedArrowLeft01, size: 22.sp),
          onPressed: () => context.pop(),
        ),
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: l10n.marketSearchHint,
            border: InputBorder.none,
          ),
          onChanged: (value) => setState(() => _query = value.trim()),
        ),
      ),
      body: pricesAsync.when(
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
          final filtered = _query.isEmpty
              ? prices
              : prices
                    .where(
                      (p) => p.commodityName.toLowerCase().contains(
                        _query.toLowerCase(),
                      ),
                    )
                    .toList();

          if (filtered.isEmpty) {
            return ListView(
              children: [
                SizedBox(height: 80.h),
                AppEmptyState(
                  message: l10n.marketSearchEmpty,
                  icon: HugeIcons.strokeRoundedSearch01,
                ),
              ],
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(16.w),
            itemCount: filtered.length,
            separatorBuilder: (_, _) => SizedBox(height: 8.h),
            itemBuilder: (context, index) =>
                MarketPriceCard(price: filtered[index]),
          );
        },
      ),
    );
  }
}
