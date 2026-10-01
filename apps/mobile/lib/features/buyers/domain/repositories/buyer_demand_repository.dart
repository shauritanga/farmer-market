import 'package:fama/core/utils/result.dart';
import 'package:fama/features/buyers/domain/entities/buyer_demand.dart';

abstract interface class BuyerDemandRepository {
  Future<Result<List<BuyerDemand>>> getOpenDemands();
}
