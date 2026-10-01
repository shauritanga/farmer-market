import 'package:fama/features/buyers/domain/entities/buyer_demand.dart';

class BuyerDemandModel {
  const BuyerDemandModel({required this.entity});

  final BuyerDemand entity;

  factory BuyerDemandModel.fromJson(Map<String, dynamic> json) {
    final commodity = json['commodity'] as Map<String, dynamic>;
    final buyer = json['buyer'] as Map<String, dynamic>?;
    final buyerUser = buyer?['user'] as Map<String, dynamic>?;
    // Prisma Decimal serializes as a numeric string over the wire.
    final offerPrice = json['offerPrice'] as String?;

    return BuyerDemandModel(
      entity: BuyerDemand(
        id: json['id'] as String,
        commodityName: commodity['name'] as String,
        quantity: (json['quantity'] as num).toDouble(),
        unit: json['unit'] as String,
        grade: json['grade'] as String?,
        targetLocation: json['targetLocation'] as String,
        offerPrice: offerPrice == null ? null : double.parse(offerPrice),
        requiredBy: DateTime.parse(json['requiredBy'] as String),
        paymentTerms: json['paymentTerms'] as String?,
        createdAt: DateTime.parse(json['createdAt'] as String),
        buyerName: buyerUser?['name'] as String?,
        businessName: buyer?['businessName'] as String?,
      ),
    );
  }
}
