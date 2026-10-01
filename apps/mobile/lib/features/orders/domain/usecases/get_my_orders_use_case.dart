import 'package:fama/core/utils/result.dart';
import 'package:fama/features/orders/domain/entities/order.dart';
import 'package:fama/features/orders/domain/repositories/orders_repository.dart';

class GetMyOrdersUseCase {
  const GetMyOrdersUseCase(this._repository);

  final OrdersRepository _repository;

  Future<Result<List<Order>>> call() => _repository.getMyOrders();
}
