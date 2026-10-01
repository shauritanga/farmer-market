import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/inputs/data/datasources/inputs_remote_data_source.dart';
import 'package:fama/features/inputs/data/repositories/inputs_repository_impl.dart';
import 'package:fama/features/inputs/domain/entities/agro_input.dart';
import 'package:fama/features/inputs/domain/entities/agro_input_order.dart';
import 'package:fama/features/inputs/domain/repositories/inputs_repository.dart';
import 'package:fama/features/inputs/domain/usecases/create_agro_input_order_use_case.dart';
import 'package:fama/features/inputs/domain/usecases/get_agro_inputs_use_case.dart';
import 'package:fama/features/inputs/domain/usecases/get_my_agro_input_orders_use_case.dart';

final inputsRemoteDataSourceProvider = Provider<InputsRemoteDataSource>((ref) {
  return InputsRemoteDataSource(ref.watch(apiClientProvider).dio);
});

final inputsRepositoryProvider = Provider<InputsRepository>((ref) {
  return InputsRepositoryImpl(ref.watch(inputsRemoteDataSourceProvider));
});

final getAgroInputsUseCaseProvider = Provider<GetAgroInputsUseCase>((ref) {
  return GetAgroInputsUseCase(ref.watch(inputsRepositoryProvider));
});

final createAgroInputOrderUseCaseProvider =
    Provider<CreateAgroInputOrderUseCase>((ref) {
      return CreateAgroInputOrderUseCase(ref.watch(inputsRepositoryProvider));
    });

final getMyAgroInputOrdersUseCaseProvider =
    Provider<GetMyAgroInputOrdersUseCase>((ref) {
      return GetMyAgroInputOrdersUseCase(ref.watch(inputsRepositoryProvider));
    });

final inputsCatalogProvider = FutureProvider.autoDispose<List<AgroInput>>((
  ref,
) async {
  final result = await ref.read(getAgroInputsUseCaseProvider).call();
  return result.when(success: (inputs) => inputs, failure: (f) => throw f);
});

final myInputOrdersProvider = FutureProvider.autoDispose<List<AgroInputOrder>>((
  ref,
) async {
  final result = await ref.read(getMyAgroInputOrdersUseCaseProvider).call();
  return result.when(success: (orders) => orders, failure: (f) => throw f);
});
