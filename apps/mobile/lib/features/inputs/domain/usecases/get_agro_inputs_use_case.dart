import 'package:fama/core/utils/result.dart';
import 'package:fama/features/inputs/domain/entities/agro_input.dart';
import 'package:fama/features/inputs/domain/repositories/inputs_repository.dart';

class GetAgroInputsUseCase {
  const GetAgroInputsUseCase(this._repository);

  final InputsRepository _repository;

  Future<Result<List<AgroInput>>> call() => _repository.getInputs();
}
