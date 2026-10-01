import 'package:fama/core/utils/result.dart';
import 'package:fama/features/market_prices/domain/entities/market_price.dart';
import 'package:fama/features/market_prices/domain/repositories/market_prices_repository.dart';

class GetCurrentMarketPricesUseCase {
  const GetCurrentMarketPricesUseCase(this._repository);

  final MarketPricesRepository _repository;

  Future<Result<List<MarketPrice>>> call() => _repository.getCurrentPrices();
}
