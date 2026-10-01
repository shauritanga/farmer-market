import 'package:fama/features/orders/domain/entities/order.dart';

class OrderModel {
  const OrderModel({required this.entity});

  final Order entity;

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    final commodity = json['commodity'] as Map<String, dynamic>;

    return OrderModel(
      entity: Order(
        id: json['id'] as String,
        commodityName: commodity['name'] as String,
        quantity: (json['quantity'] as num).toDouble(),
        unit: json['unit'] as String,
        // Prisma Decimal serializes as a numeric string over the wire.
        price: double.parse(json['price'] as String),
        pickupLocation: json['pickupLocation'] as String,
        deliveryLocation: json['deliveryLocation'] as String,
        status: json['status'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
      ),
    );
  }
}
