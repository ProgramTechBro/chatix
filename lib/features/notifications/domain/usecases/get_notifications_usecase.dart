import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/notifications_repository.dart';
import '../entities/notification_entity.dart';

@injectable
class GetNotificationsUseCase {
  const GetNotificationsUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, List<NotificationEntity>>> call() => _repository.getNotifications();
}
