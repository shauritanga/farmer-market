import 'package:fama/features/market_prices/domain/entities/market_price.dart';

/// The Home tab's "top 10 products in the top market" — the top market
/// itself is derived from data (most recorded prices), not hardcoded.
class TopMarketPrices {
  const TopMarketPrices({
    required this.marketName,
    required this.marketRegion,
    required this.prices,
  });

  /// Null when there's no price data recorded anywhere yet.
  final String? marketName;
  final String? marketRegion;
  final List<MarketPrice> prices;
}
