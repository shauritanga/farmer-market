import 'package:fama/core/utils/result.dart';
import 'package:fama/features/market_prices/domain/entities/top_market_prices.dart';
import 'package:fama/features/market_prices/domain/repositories/market_prices_repository.dart';

class GetTopMarketPricesUseCase {
  const GetTopMarketPricesUseCase(this._repository);

  final MarketPricesRepository _repository;

  Future<Result<TopMarketPrices>> call() => _repository.getTopMarketPrices();
}
