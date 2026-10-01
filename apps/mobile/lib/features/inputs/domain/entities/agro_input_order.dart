/// A farmer's order request for an agricultural input. Starts at
/// REQUESTED — confirmation and delivery are handled by the supplier
/// side, so the farmer tracks status here rather than assuming it.
class AgroInputOrder {
  const AgroInputOrder({
    required this.id,
    required this.inputId,
    required this.inputName,
    required this.unit,
    required this.quantity,
    required this.unitPrice,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String inputId;
  final String inputName;
  final String unit;
  final double quantity;

  /// Price per unit snapshot at order time — the catalog price may move
  /// afterwards, but this order's agreed price does not.
  final double unitPrice;

  /// One of REQUESTED, CONFIRMED, DELIVERED, CANCELLED.
  final String status;
  final DateTime createdAt;

  double get totalPrice => quantity * unitPrice;
}
