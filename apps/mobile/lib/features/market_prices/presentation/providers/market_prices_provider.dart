import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/market_prices/data/datasources/market_prices_remote_data_source.dart';
import 'package:fama/features/market_prices/data/repositories/market_prices_repository_impl.dart';
import 'package:fama/features/market_prices/domain/entities/market_price.dart';
import 'package:fama/features/market_prices/domain/entities/top_market_prices.dart';
import 'package:fama/features/market_prices/domain/repositories/market_prices_repository.dart';
import 'package:fama/features/market_prices/domain/usecases/get_current_market_prices_use_case.dart';
import 'package:fama/features/market_prices/domain/usecases/get_top_market_prices_use_case.dart';

final marketPricesRemoteDataSourceProvider =
    Provider<MarketPricesRemoteDataSource>((ref) {
      return MarketPricesRemoteDataSource(ref.watch(apiClientProvider).dio);
    });

final marketPricesRepositoryProvider = Provider<MarketPricesRepository>((ref) {
  return MarketPricesRepositoryImpl(
    ref.watch(marketPricesRemoteDataSourceProvider),
  );
});

final getCurrentMarketPricesUseCaseProvider =
    Provider<GetCurrentMarketPricesUseCase>((ref) {
      return GetCurrentMarketPricesUseCase(
        ref.watch(marketPricesRepositoryProvider),
      );
    });

/// Autodispose: refetch every time the Market tab is opened rather than
/// caching stale prices indefinitely — see product-spec.md §3 (Trust:
/// users should know prices are current).
final marketPricesProvider = FutureProvider.autoDispose<List<MarketPrice>>((
  ref,
) async {
  final result = await ref.read(getCurrentMarketPricesUseCaseProvider).call();
  return result.when(success: (prices) => prices, failure: (f) => throw f);
});

final getTopMarketPricesUseCaseProvider = Provider<GetTopMarketPricesUseCase>((
  ref,
) {
  return GetTopMarketPricesUseCase(ref.watch(marketPricesRepositoryProvider));
});

/// The Home tab's "top 10 products in the top market" preview.
final topMarketPricesProvider = FutureProvider.autoDispose<TopMarketPrices>((
  ref,
) async {
  final result = await ref.read(getTopMarketPricesUseCaseProvider).call();
  return result.when(success: (top) => top, failure: (f) => throw f);
});
