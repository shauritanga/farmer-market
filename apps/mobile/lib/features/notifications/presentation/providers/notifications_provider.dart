import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fama/features/authentication/presentation/providers/auth_provider.dart';
import 'package:fama/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:fama/features/notifications/data/repositories/notifications_repository_impl.dart';
import 'package:fama/features/notifications/domain/entities/app_notification.dart';
import 'package:fama/features/notifications/domain/repositories/notifications_repository.dart';
import 'package:fama/features/notifications/domain/usecases/get_my_notifications_use_case.dart';

final notificationsRemoteDataSourceProvider =
    Provider<NotificationsRemoteDataSource>((ref) {
      return NotificationsRemoteDataSource(ref.watch(apiClientProvider).dio);
    });

final notificationsRepositoryProvider = Provider<NotificationsRepository>((
  ref,
) {
  return NotificationsRepositoryImpl(
    ref.watch(notificationsRemoteDataSourceProvider),
  );
});

final getMyNotificationsUseCaseProvider = Provider<GetMyNotificationsUseCase>((
  ref,
) {
  return GetMyNotificationsUseCase(ref.watch(notificationsRepositoryProvider));
});

final myNotificationsProvider =
    FutureProvider.autoDispose<List<AppNotification>>((ref) async {
      final result = await ref.read(getMyNotificationsUseCaseProvider).call();
      return result.when(
        success: (notifications) => notifications,
        failure: (f) => throw f,
      );
    });
