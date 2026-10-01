/// One of the current farmer's own produce listings.
class ProduceListing {
  const ProduceListing({
    required this.id,
    required this.commodityName,
    required this.quantityAvailable,
    required this.unit,
    required this.location,
    required this.availableFrom,
    required this.isNegotiable,
    required this.status,
    this.grade,
    this.expectedPrice,
  });

  final String id;
  final String commodityName;
  final double quantityAvailable;
  final String unit;
  final String? grade;
  final String location;
  final DateTime availableFrom;
  final double? expectedPrice;
  final bool isNegotiable;

  /// One of ACTIVE, PAUSED, SOLD_OUT, CLOSED.
  final String status;
}
