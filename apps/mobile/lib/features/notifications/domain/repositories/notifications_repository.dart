import 'package:fama/core/utils/result.dart';
import 'package:fama/features/notifications/domain/entities/app_notification.dart';

abstract interface class NotificationsRepository {
  Future<Result<List<AppNotification>>> getMyNotifications();
}
