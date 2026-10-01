import 'package:fama/core/utils/result.dart';
import 'package:fama/features/produce/domain/entities/produce_listing.dart';

abstract interface class ProduceRepository {
  Future<Result<List<ProduceListing>>> getMyListings();
}
