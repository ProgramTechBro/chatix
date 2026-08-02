import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/device_token_entity.dart';
import '../entities/notification_entity.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications();

  Future<Either<Failure, void>> saveDeviceToken(DeviceTokenEntity token);
}
