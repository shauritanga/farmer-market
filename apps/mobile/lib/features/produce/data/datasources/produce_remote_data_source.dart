import 'package:dio/dio.dart';

import 'package:fama/features/produce/data/models/produce_listing_model.dart';

class ProduceRemoteDataSource {
  const ProduceRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<ProduceListingModel>> getMyListings() async {
    final response = await _dio.get('/produce/mine');
    return (response.data as List)
        .cast<Map<String, dynamic>>()
        .map(ProduceListingModel.fromJson)
        .toList();
  }
}
