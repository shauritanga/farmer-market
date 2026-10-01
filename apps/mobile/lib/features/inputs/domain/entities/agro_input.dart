/// One agricultural input (seed, fertilizer, pesticide...) a farmer can
/// browse and order from the catalog.
class AgroInput {
  const AgroInput({
    required this.id,
    required this.name,
    required this.category,
    required this.unit,
    required this.price,
    required this.currency,
    this.stockQuantity,
    this.supplierName,
    this.description,
  });

  final String id;
  final String name;

  /// E.g. SEED, FERTILIZER, PESTICIDE — free-form category label.
  final String category;
  final String unit;
  final double price;
  final String currency;

  /// Null means stock is not tracked for this input.
  final double? stockQuantity;
  final String? supplierName;
  final String? description;

  bool get inStock => stockQuantity == null || stockQuantity! > 0;
}
