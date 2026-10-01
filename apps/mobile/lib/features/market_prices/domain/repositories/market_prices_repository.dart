import 'package:fama/core/utils/result.dart';
import 'package:fama/features/market_prices/domain/entities/market_price.dart';
import 'package:fama/features/market_prices/domain/entities/top_market_prices.dart';

abstract interface class MarketPricesRepository {
  Future<Result<List<MarketPrice>>> getCurrentPrices();

  Future<Result<TopMarketPrices>> getTopMarketPrices();
}
