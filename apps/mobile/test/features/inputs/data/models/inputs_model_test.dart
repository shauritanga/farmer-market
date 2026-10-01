import 'package:flutter_test/flutter_test.dart';

import 'package:fama/features/inputs/data/models/agro_input_model.dart';
import 'package:fama/features/inputs/data/models/agro_input_order_model.dart';

void main() {
  group('AgroInputModel.fromJson', () {
    test('parses a catalog payload', () {
      final model = AgroInputModel.fromJson({
        'id': 'input-1',
        'name': 'Urea Fertilizer',
        'category': 'FERTILIZER',
        'unit': 'bag',
        'price': '85000',
        'currency': 'TZS',
        'stockQuantity': 200,
        'supplierName': 'Agro Supply Co.',
        'description': 'Nitrogen fertilizer, 50kg bag.',
      });

      final input = model.entity;
      expect(input.name, 'Urea Fertilizer');
      expect(input.price, 85000);
      expect(input.inStock, isTrue);
    });

    test('flags zero stock as out of stock', () {
      final model = AgroInputModel.fromJson({
        'id': 'input-2',
        'name': 'Maize Seed (Hybrid)',
        'category': 'SEED',
        'unit': 'bag',
        'price': '45000',
        'currency': 'TZS',
        'stockQuantity': 0,
        'supplierName': null,
        'description': null,
      });

      expect(model.entity.inStock, isFalse);
    });
  });

  group('AgroInputOrderModel.fromJson', () {
    test('parses an order with its input snapshot', () {
      final model = AgroInputOrderModel.fromJson({
        'id': 'order-1',
        'inputId': 'input-1',
        'quantity': 2,
        'unitPrice': '85000',
        'status': 'REQUESTED',
        'createdAt': '2026-09-28T08:00:00.000Z',
        'input': {'name': 'Urea Fertilizer', 'unit': 'bag'},
      });

      final order = model.entity;
      expect(order.inputName, 'Urea Fertilizer');
      expect(order.quantity, 2);
      expect(order.totalPrice, 170000);
      expect(order.status, 'REQUESTED');
    });
  });
}
