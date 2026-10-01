import 'package:dio/dio.dart';

import 'package:fama/core/network/dio_error_mapper.dart';
import 'package:fama/core/utils/result.dart';
import 'package:fama/features/notifications/data/datasources/notifications_remote_data_source.dart';
import 'package:fama/features/notifications/domain/entities/app_notification.dart';
import 'package:fama/features/notifications/domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(this._remoteDataSource);

  final NotificationsRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<AppNotification>>> getMyNotifications() async {
    try {
      final models = await _remoteDataSource.getMyNotifications();
      return Result.success(models.map((m) => m.entity).toList());
    } on DioException catch (e) {
      return Result.failure(mapDioError(e));
    }
  }
}
