import 'package:fama/core/utils/result.dart';
import 'package:fama/features/orders/domain/entities/order.dart';

abstract interface class OrdersRepository {
  Future<Result<List<Order>>> getMyOrders();
}
