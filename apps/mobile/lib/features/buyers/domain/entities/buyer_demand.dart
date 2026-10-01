/// A buyer's open purchase request, as a farmer sees it when browsing
/// demand — see docs/product/product-spec.md §7 (Buyer Marketplace).
class BuyerDemand {
  const BuyerDemand({
    required this.id,
    required this.commodityName,
    required this.quantity,
    required this.unit,
    required this.targetLocation,
    required this.requiredBy,
    required this.createdAt,
    this.grade,
    this.offerPrice,
    this.paymentTerms,
    this.buyerName,
    this.businessName,
  });

  final String id;
  final String commodityName;
  final double quantity;
  final String unit;
  final String? grade;
  final String targetLocation;
  final double? offerPrice;
  final DateTime requiredBy;
  final String? paymentTerms;
  final DateTime createdAt;

  /// Display name of the requesting buyer (personal name).
  final String? buyerName;

  /// Buyer's business/trading name, when they have one.
  final String? businessName;

  /// "Business Name" when set, else the buyer's personal name, else null.
  String? get displayBuyer => businessName ?? buyerName;
}
