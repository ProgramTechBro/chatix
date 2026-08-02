import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/device_token_entity.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repositories/notifications_repository.dart';
import '../datasources/fcm_token_datasource.dart';
import '../datasources/local/notifications_local_datasource.dart';
import '../models/device_token_model.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(
    this._localDataSource,
    this._fcmTokenDataSource,
  );

  final NotificationsLocalDataSource _localDataSource;
  final FcmTokenDataSource _fcmTokenDataSource;

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    final notifications = await _localDataSource.getNotifications();
    return Right(List<NotificationEntity>.of(notifications));
  }

  @override
  Future<Either<Failure, void>> saveDeviceToken(DeviceTokenEntity token) async {
    try {
      await _fcmTokenDataSource.saveDeviceToken(
        DeviceTokenModel(
          userId: token.userId,
          token: token.token,
          platform: token.platform,
        ),
      );
      return const Right(null);
    } catch (_) {
      return const Left(ServerFailure('Could not save device token.'));
    }
  }
}
