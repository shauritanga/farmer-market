import 'package:fama/core/utils/result.dart';
import 'package:fama/features/produce/domain/entities/produce_listing.dart';
import 'package:fama/features/produce/domain/repositories/produce_repository.dart';

class GetMyProduceListingsUseCase {
  const GetMyProduceListingsUseCase(this._repository);

  final ProduceRepository _repository;

  Future<Result<List<ProduceListing>>> call() => _repository.getMyListings();
}
