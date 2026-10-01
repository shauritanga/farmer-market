import 'package:fama/core/utils/result.dart';
import 'package:fama/features/inputs/domain/entities/agro_input_order.dart';
import 'package:fama/features/inputs/domain/repositories/inputs_repository.dart';

class GetMyAgroInputOrdersUseCase {
  const GetMyAgroInputOrdersUseCase(this._repository);

  final InputsRepository _repository;

  Future<Result<List<AgroInputOrder>>> call() => _repository.getMyOrders();
}
