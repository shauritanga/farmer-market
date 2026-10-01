import 'package:fama/features/produce/domain/entities/produce_listing.dart';

class ProduceListingModel {
  const ProduceListingModel({required this.entity});

  final ProduceListing entity;

  factory ProduceListingModel.fromJson(Map<String, dynamic> json) {
    final commodity = json['commodity'] as Map<String, dynamic>;
    final expectedPrice = json['expectedPrice'] as String?;

    return ProduceListingModel(
      entity: ProduceListing(
        id: json['id'] as String,
        commodityName: commodity['name'] as String,
        quantityAvailable: (json['quantityAvailable'] as num).toDouble(),
        unit: json['unit'] as String,
        grade: json['grade'] as String?,
        location: json['location'] as String,
        availableFrom: DateTime.parse(json['availableFrom'] as String),
        expectedPrice: expectedPrice == null
            ? null
            : double.parse(expectedPrice),
        isNegotiable: json['isNegotiable'] as bool,
        status: json['status'] as String,
      ),
    );
  }
}
