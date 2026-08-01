import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/notification_entity.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();
}
