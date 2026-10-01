import 'package:fama/features/inputs/domain/entities/agro_input.dart';

class AgroInputModel {
  const AgroInputModel({required this.entity});

  final AgroInput entity;

  factory AgroInputModel.fromJson(Map<String, dynamic> json) {
    return AgroInputModel(
      entity: AgroInput(
        id: json['id'] as String,
        name: json['name'] as String,
        category: json['category'] as String,
        unit: json['unit'] as String,
        // Prisma Decimal serializes as a numeric string over the wire.
        price: double.parse(json['price'] as String),
        currency: json['currency'] as String,
        stockQuantity: (json['stockQuantity'] as num?)?.toDouble(),
        supplierName: json['supplierName'] as String?,
        description: json['description'] as String?,
      ),
    );
  }
}
