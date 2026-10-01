import 'package:dio/dio.dart';

import 'package:fama/core/network/dio_error_mapper.dart';
import 'package:fama/core/utils/result.dart';
import 'package:fama/features/market_prices/data/datasources/market_prices_remote_data_source.dart';
import 'package:fama/features/market_prices/domain/entities/market_price.dart';
import 'package:fama/features/market_prices/domain/entities/top_market_prices.dart';
import 'package:fama/features/market_prices/domain/repositories/market_prices_repository.dart';

class MarketPricesRepositoryImpl implements MarketPricesRepository {
  const MarketPricesRepositoryImpl(this._remoteDataSource);

  final MarketPricesRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<MarketPrice>>> getCurrentPrices() async {
    try {
      final models = await _remoteDataSource.getCurrentPrices();
      return Result.success(models.map((m) => m.entity).toList());
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }

  @override
  Future<Result<TopMarketPrices>> getTopMarketPrices() async {
    try {
      final result = await _remoteDataSource.getTopMarket();
      return Result.success(
        TopMarketPrices(
          marketName: result.marketName,
          marketRegion: result.marketRegion,
          prices: result.prices.map((m) => m.entity).toList(),
        ),
      );
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }
}
