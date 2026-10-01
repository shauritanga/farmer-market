import 'package:fama/features/market_prices/domain/entities/market_price.dart';

class MarketPriceModel {
  const MarketPriceModel({required this.entity});

  final MarketPrice entity;

  factory MarketPriceModel.fromJson(Map<String, dynamic> json) {
    final commodity = json['commodity'] as Map<String, dynamic>;
    final market = json['market'] as Map<String, dynamic>;

    return MarketPriceModel(
      entity: MarketPrice(
        commodityName: commodity['name'] as String,
        marketName: market['name'] as String,
        marketRegion: market['region'] as String,
        // Prisma Decimal serializes as a numeric string over the wire.
        price: double.parse(json['price'] as String),
        currency: json['currency'] as String,
        unit: json['unit'] as String,
        priceType: json['priceType'] as String,
        recordedAt: DateTime.parse(json['recordedAt'] as String),
        grade: json['grade'] as String?,
      ),
    );
  }
}
