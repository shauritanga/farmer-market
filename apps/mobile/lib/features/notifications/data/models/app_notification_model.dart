import 'package:fama/features/notifications/domain/entities/app_notification.dart';

class AppNotificationModel {
  const AppNotificationModel({required this.entity});

  final AppNotification entity;

  factory AppNotificationModel.fromJson(Map<String, dynamic> json) {
    return AppNotificationModel(
      entity: AppNotification(
        id: json['id'] as String,
        type: json['type'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        isRead: json['isRead'] as bool,
        createdAt: DateTime.parse(json['createdAt'] as String),
      ),
    );
  }
}
