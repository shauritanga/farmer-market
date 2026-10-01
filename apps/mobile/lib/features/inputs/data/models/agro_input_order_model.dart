import 'package:fama/features/inputs/domain/entities/agro_input_order.dart';

class AgroInputOrderModel {
  const AgroInputOrderModel({required this.entity});

  final AgroInputOrder entity;

  factory AgroInputOrderModel.fromJson(Map<String, dynamic> json) {
    final input = json['input'] as Map<String, dynamic>?;

    return AgroInputOrderModel(
      entity: AgroInputOrder(
        id: json['id'] as String,
        inputId: json['inputId'] as String,
        inputName: input?['name'] as String? ?? '',
        unit: input?['unit'] as String? ?? '',
        quantity: (json['quantity'] as num).toDouble(),
        // Prisma Decimal serializes as a numeric string over the wire.
        unitPrice: double.parse(json['unitPrice'] as String),
        status: json['status'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      ),
    );
  }
}
