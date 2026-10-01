import 'package:dio/dio.dart';

import 'package:fama/features/inputs/data/models/agro_input_model.dart';
import 'package:fama/features/inputs/data/models/agro_input_order_model.dart';

class InputsRemoteDataSource {
  const InputsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<AgroInputModel>> getInputs() async {
    final response = await _dio.get('/inputs');
    return (response.data as List)
        .cast<Map<String, dynamic>>()
        .map(AgroInputModel.fromJson)
        .toList();
  }

  Future<AgroInputOrderModel> createOrder({
    required String inputId,
    required double quantity,
  }) async {
    final response = await _dio.post(
      '/inputs/orders',
      data: {'inputId': inputId, 'quantity': quantity},
    );
    return AgroInputOrderModel.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<AgroInputOrderModel>> getMyOrders() async {
    final response = await _dio.get('/inputs/orders/mine');
    return (response.data as List)
        .cast<Map<String, dynamic>>()
        .map(AgroInputOrderModel.fromJson)
        .toList();
  }
}
