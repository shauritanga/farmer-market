import 'package:dio/dio.dart';

import 'package:fama/features/market_prices/data/models/market_price_model.dart';

class MarketPricesRemoteDataSource {
  const MarketPricesRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<MarketPriceModel>> getCurrentPrices() async {
    final response = await _dio.get('/market-prices');
    return (response.data as List)
        .cast<Map<String, dynamic>>()
        .map(MarketPriceModel.fromJson)
        .toList();
  }

  /// The market with the most recorded prices, and up to 10 of its latest
  /// distinct-commodity prices. Market fields are null if there's no price
  /// data at all yet.
  Future<
    ({String? marketName, String? marketRegion, List<MarketPriceModel> prices})
  >
  getTopMarket() async {
    final response = await _dio.get('/market-prices/top');
    final data = response.data as Map<String, dynamic>;
    final market = data['market'] as Map<String, dynamic>?;
    return (
      marketName: market?['name'] as String?,
      marketRegion: market?['region'] as String?,
      prices: (data['prices'] as List)
          .cast<Map<String, dynamic>>()
          .map(MarketPriceModel.fromJson)
          .toList(),
    );
  }
}
