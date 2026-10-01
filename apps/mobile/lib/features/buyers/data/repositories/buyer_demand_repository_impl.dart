import 'package:dio/dio.dart';

import 'package:fama/core/network/dio_error_mapper.dart';
import 'package:fama/core/utils/result.dart';
import 'package:fama/features/buyers/data/datasources/buyer_demand_remote_data_source.dart';
import 'package:fama/features/buyers/domain/entities/buyer_demand.dart';
import 'package:fama/features/buyers/domain/repositories/buyer_demand_repository.dart';

class BuyerDemandRepositoryImpl implements BuyerDemandRepository {
  const BuyerDemandRepositoryImpl(this._remoteDataSource);

  final BuyerDemandRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<BuyerDemand>>> getOpenDemands() async {
    try {
      final models = await _remoteDataSource.getOpenDemands();
      return Result.success(models.map((m) => m.entity).toList());
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }
}
