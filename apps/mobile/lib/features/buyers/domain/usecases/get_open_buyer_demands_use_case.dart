import 'package:fama/core/utils/result.dart';
import 'package:fama/features/buyers/domain/entities/buyer_demand.dart';
import 'package:fama/features/buyers/domain/repositories/buyer_demand_repository.dart';

class GetOpenBuyerDemandsUseCase {
  const GetOpenBuyerDemandsUseCase(this._repository);

  final BuyerDemandRepository _repository;

  Future<Result<List<BuyerDemand>>> call() => _repository.getOpenDemands();
}
