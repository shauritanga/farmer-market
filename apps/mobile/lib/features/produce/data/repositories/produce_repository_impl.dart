import 'package:dio/dio.dart';

import 'package:fama/core/network/dio_error_mapper.dart';
import 'package:fama/core/utils/result.dart';
import 'package:fama/features/produce/data/datasources/produce_remote_data_source.dart';
import 'package:fama/features/produce/domain/entities/produce_listing.dart';
import 'package:fama/features/produce/domain/repositories/produce_repository.dart';

class ProduceRepositoryImpl implements ProduceRepository {
  const ProduceRepositoryImpl(this._remoteDataSource);

  final ProduceRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<ProduceListing>>> getMyListings() async {
    try {
      final models = await _remoteDataSource.getMyListings();
      return Result.success(models.map((m) => m.entity).toList());
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }
}
