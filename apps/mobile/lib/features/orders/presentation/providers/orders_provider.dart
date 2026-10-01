import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/orders/data/datasources/orders_remote_data_source.dart';
import 'package:fama/features/orders/data/repositories/orders_repository_impl.dart';
import 'package:fama/features/orders/domain/entities/order.dart';
import 'package:fama/features/orders/domain/repositories/orders_repository.dart';
import 'package:fama/features/orders/domain/usecases/get_my_orders_use_case.dart';

final ordersRemoteDataSourceProvider = Provider<OrdersRemoteDataSource>((ref) {
  return OrdersRemoteDataSource(ref.watch(apiClientProvider).dio);
});

final ordersRepositoryProvider = Provider<OrdersRepository>((ref) {
  return OrdersRepositoryImpl(ref.watch(ordersRemoteDataSourceProvider));
});

final getMyOrdersUseCaseProvider = Provider<GetMyOrdersUseCase>((ref) {
  return GetMyOrdersUseCase(ref.watch(ordersRepositoryProvider));
});

final myOrdersProvider = FutureProvider.autoDispose<List<Order>>((ref) async {
  final result = await ref.read(getMyOrdersUseCaseProvider).call();
  return result.when(success: (orders) => orders, failure: (f) => throw f);
});
