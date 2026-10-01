import 'package:dio/dio.dart';

import 'package:fama/core/network/dio_error_mapper.dart';
import 'package:fama/core/utils/result.dart';
import 'package:fama/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:fama/features/orders/domain/entities/order.dart';
import 'package:fama/features/orders/domain/repositories/orders_repository.dart';

class OrdersRepositoryImpl implements OrdersRepository {
  const OrdersRepositoryImpl(this._remoteDataSource);

  final OrdersRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<Order>>> getMyOrders() async {
    try {
      final models = await _remoteDataSource.getMyOrders();
      return Result.success(models.map((m) => m.entity).toList());
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }
}
