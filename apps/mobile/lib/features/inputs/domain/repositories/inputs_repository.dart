import 'package:fama/core/utils/result.dart';
import 'package:fama/features/inputs/domain/entities/agro_input.dart';
import 'package:fama/features/inputs/domain/entities/agro_input_order.dart';

abstract interface class InputsRepository {
  Future<Result<List<AgroInput>>> getInputs();

  Future<Result<AgroInputOrder>> createOrder({
    required String inputId,
    required double quantity,
  });

  Future<Result<List<AgroInputOrder>>> getMyOrders();
}
