import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/buyers/data/datasources/buyer_demand_remote_data_source.dart';
import 'package:fama/features/buyers/data/repositories/buyer_demand_repository_impl.dart';
import 'package:fama/features/buyers/domain/entities/buyer_demand.dart';
import 'package:fama/features/buyers/domain/repositories/buyer_demand_repository.dart';
import 'package:fama/features/buyers/domain/usecases/get_open_buyer_demands_use_case.dart';

final buyerDemandRemoteDataSourceProvider =
    Provider<BuyerDemandRemoteDataSource>((ref) {
      return BuyerDemandRemoteDataSource(ref.watch(apiClientProvider).dio);
    });

final buyerDemandRepositoryProvider = Provider<BuyerDemandRepository>((ref) {
  return BuyerDemandRepositoryImpl(
    ref.watch(buyerDemandRemoteDataSourceProvider),
  );
});

final getOpenBuyerDemandsUseCaseProvider = Provider<GetOpenBuyerDemandsUseCase>(
  (ref) {
    return GetOpenBuyerDemandsUseCase(ref.watch(buyerDemandRepositoryProvider));
  },
);

final openBuyerDemandsProvider = FutureProvider.autoDispose<List<BuyerDemand>>((
  ref,
) async {
  final result = await ref.read(getOpenBuyerDemandsUseCaseProvider).call();
  return result.when(success: (demands) => demands, failure: (f) => throw f);
});
