/// A single market price observation. Always carries freshness/context —
/// see docs/product/product-spec.md §5 (Market Price Model): a price
/// without commodity/market/unit/timestamp/source is meaningless.
class MarketPrice {
  const MarketPrice({
    required this.commodityName,
    required this.marketName,
    required this.marketRegion,
    required this.price,
    required this.currency,
    required this.unit,
    required this.priceType,
    required this.recordedAt,
    this.grade,
  });

  final String commodityName;
  final String marketName;
  final String marketRegion;
  final double price;
  final String currency;
  final String unit;

  /// One of INDICATIVE, REPORTED, BUYER_OFFER, COMPLETED_TRANSACTION — never
  /// collapse this into just a number (see product-spec.md §5).
  final String priceType;
  final DateTime recordedAt;
  final String? grade;
}
