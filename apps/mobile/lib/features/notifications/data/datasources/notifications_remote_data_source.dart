import 'package:dio/dio.dart';

import 'package:fama/features/notifications/data/models/app_notification_model.dart';

class NotificationsRemoteDataSource {
  const NotificationsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<AppNotificationModel>> getMyNotifications() async {
    final response = await _dio.get('/notifications');
    return (response.data as List)
        .cast<Map<String, dynamic>>()
        .map(AppNotificationModel.fromJson)
        .toList();
  }
}
