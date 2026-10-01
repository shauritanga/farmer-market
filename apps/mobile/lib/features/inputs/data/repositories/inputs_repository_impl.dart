import 'package:dio/dio.dart';

import 'package:fama/core/network/dio_error_mapper.dart';
import 'package:fama/core/utils/result.dart';
import 'package:fama/features/inputs/data/datasources/inputs_remote_data_source.dart';
import 'package:fama/features/inputs/domain/entities/agro_input.dart';
import 'package:fama/features/inputs/domain/entities/agro_input_order.dart';
import 'package:fama/features/inputs/domain/repositories/inputs_repository.dart';

class InputsRepositoryImpl implements InputsRepository {
  const InputsRepositoryImpl(this._remoteDataSource);

  final InputsRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<AgroInput>>> getInputs() async {
    try {
      final models = await _remoteDataSource.getInputs();
      return Result.success(models.map((m) => m.entity).toList());
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }

  @override
  Future<Result<AgroInputOrder>> createOrder({
    required String inputId,
    required double quantity,
  }) async {
    try {
      final model = await _remoteDataSource.createOrder(
        inputId: inputId,
        quantity: quantity,
      );
      return Result.success(model.entity);
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }

  @override
  Future<Result<List<AgroInputOrder>>> getMyOrders() async {
    try {
      final models = await _remoteDataSource.getMyOrders();
      return Result.success(models.map((m) => m.entity).toList());
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }
}
