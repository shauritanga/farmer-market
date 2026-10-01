import 'package:dio/dio.dart';

import 'package:fama/features/buyers/data/models/buyer_demand_model.dart';

class BuyerDemandRemoteDataSource {
  const BuyerDemandRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<BuyerDemandModel>> getOpenDemands() async {
    final response = await _dio.get('/buyer-demand');
    return (response.data as List)
        .cast<Map<String, dynamic>>()
        .map(BuyerDemandModel.fromJson)
        .toList();
  }
}
