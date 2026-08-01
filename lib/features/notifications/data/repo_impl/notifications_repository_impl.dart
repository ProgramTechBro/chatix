import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/notification_entity.dart';
import '../datasources/local/notifications_local_datasource.dart';
import '../repo/notifications_repository.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  const NotificationsRepositoryImpl(this._localDataSource);

  final NotificationsLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications() async {
    final notifications = await _localDataSource.getNotifications();
    return Right(List<NotificationEntity>.of(notifications));
  }
}
