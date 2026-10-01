import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/produce/data/datasources/produce_remote_data_source.dart';
import 'package:fama/features/produce/data/repositories/produce_repository_impl.dart';
import 'package:fama/features/produce/domain/entities/produce_listing.dart';
import 'package:fama/features/produce/domain/repositories/produce_repository.dart';
import 'package:fama/features/produce/domain/usecases/get_my_produce_listings_use_case.dart';

final produceRemoteDataSourceProvider = Provider<ProduceRemoteDataSource>((
  ref,
) {
  return ProduceRemoteDataSource(ref.watch(apiClientProvider).dio);
});

final produceRepositoryProvider = Provider<ProduceRepository>((ref) {
  return ProduceRepositoryImpl(ref.watch(produceRemoteDataSourceProvider));
});

final getMyProduceListingsUseCaseProvider =
    Provider<GetMyProduceListingsUseCase>((ref) {
      return GetMyProduceListingsUseCase(ref.watch(produceRepositoryProvider));
    });

final myProduceListingsProvider =
    FutureProvider.autoDispose<List<ProduceListing>>((ref) async {
      final result = await ref.read(getMyProduceListingsUseCaseProvider).call();
      return result.when(
        success: (listings) => listings,
        failure: (f) => throw f,
      );
    });
