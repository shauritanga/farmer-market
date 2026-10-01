import 'package:dio/dio.dart';

import 'package:fama/features/orders/data/models/order_model.dart';

class OrdersRemoteDataSource {
  const OrdersRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<OrderModel>> getMyOrders() async {
    final response = await _dio.get('/orders/mine');
    return (response.data as List)
        .cast<Map<String, dynamic>>()
        .map(OrderModel.fromJson)
        .toList();
  }
}
