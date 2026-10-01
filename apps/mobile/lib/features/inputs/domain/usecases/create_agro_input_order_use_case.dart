import 'package:fama/core/utils/result.dart';
import 'package:fama/features/inputs/domain/entities/agro_input_order.dart';
import 'package:fama/features/inputs/domain/repositories/inputs_repository.dart';

class CreateAgroInputOrderUseCase {
  const CreateAgroInputOrderUseCase(this._repository);

  final InputsRepository _repository;

  Future<Result<AgroInputOrder>> call({
    required String inputId,
    required double quantity,
  }) => _repository.createOrder(inputId: inputId, quantity: quantity);
}
