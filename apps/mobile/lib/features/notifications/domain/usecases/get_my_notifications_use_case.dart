import 'package:fama/core/utils/result.dart';
import 'package:fama/features/notifications/domain/entities/app_notification.dart';
import 'package:fama/features/notifications/domain/repositories/notifications_repository.dart';

class GetMyNotificationsUseCase {
  const GetMyNotificationsUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<Result<List<AppNotification>>> call() =>
      _repository.getMyNotifications();
}
