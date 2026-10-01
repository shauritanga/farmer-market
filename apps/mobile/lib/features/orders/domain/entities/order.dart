/// An agreed transaction the current user is party to (as buyer or
/// farmer). The backend is the source of truth for [status] transitions —
/// see docs/architecture/architecture.md §8; this client never invents a
/// later status locally.
class Order {
  const Order({
    required this.id,
    required this.commodityName,
    required this.quantity,
    required this.unit,
    required this.price,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String commodityName;
  final double quantity;
  final String unit;
  final double price;
  final String pickupLocation;
  final String deliveryLocation;

  /// One of CREATED, ACCEPTED, PREPARING, PICKED_UP, IN_TRANSIT, DELIVERED,
  /// VERIFIED, PAID, COMPLETED, CANCELLED.
  final String status;
  final DateTime createdAt;
}
