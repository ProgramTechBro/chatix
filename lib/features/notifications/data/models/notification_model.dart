import '../../domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.avatarUrl,
    required super.title,
    required super.message,
    required super.time,
  });
}
