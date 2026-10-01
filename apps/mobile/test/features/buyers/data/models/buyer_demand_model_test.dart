import 'package:flutter_test/flutter_test.dart';

import 'package:fama/features/buyers/data/models/buyer_demand_model.dart';

void main() {
  group('BuyerDemandModel.fromJson', () {
    test('parses a full buyer demand payload', () {
      final model = BuyerDemandModel.fromJson({
        'id': 'demand-1',
        'quantity': 500,
        'unit': 'kg',
        'grade': 'Grade 1',
        'targetLocation': 'Kariakoo, Dar es Salaam',
        'offerPrice': '1200',
        'requiredBy': '2026-10-05T00:00:00.000Z',
        'paymentTerms': 'Cash on delivery',
        'createdAt': '2026-09-28T08:00:00.000Z',
        'commodity': {'name': 'Maize'},
        'buyer': {
          'businessName': 'City Millers',
          'user': {'name': 'Amina Juma'},
        },
      });

      final demand = model.entity;
      expect(demand.id, 'demand-1');
      expect(demand.commodityName, 'Maize');
      expect(demand.quantity, 500);
      expect(demand.unit, 'kg');
      expect(demand.grade, 'Grade 1');
      expect(demand.targetLocation, 'Kariakoo, Dar es Salaam');
      expect(demand.offerPrice, 1200);
      expect(demand.paymentTerms, 'Cash on delivery');
      expect(demand.displayBuyer, 'City Millers');
    });

    test('tolerates missing optional fields', () {
      final model = BuyerDemandModel.fromJson({
        'id': 'demand-2',
        'quantity': 100.5,
        'unit': 'bag',
        'grade': null,
        'targetLocation': 'Arusha',
        'offerPrice': null,
        'requiredBy': '2026-11-01T00:00:00.000Z',
        'paymentTerms': null,
        'createdAt': '2026-09-28T08:00:00.000Z',
        'commodity': {'name': 'Beans'},
        'buyer': {
          'businessName': null,
          'user': {'name': 'John Doe'},
        },
      });

      final demand = model.entity;
      expect(demand.grade, isNull);
      expect(demand.offerPrice, isNull);
      expect(demand.paymentTerms, isNull);
      expect(demand.displayBuyer, 'John Doe');
    });
  });
}
