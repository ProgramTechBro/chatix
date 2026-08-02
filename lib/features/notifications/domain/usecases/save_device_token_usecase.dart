import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/device_token_entity.dart';
import '../repositories/notifications_repository.dart';

@injectable
class SaveDeviceTokenUseCase {
  const SaveDeviceTokenUseCase(this._repository);

  final NotificationsRepository _repository;

  Future<Either<Failure, void>> call(DeviceTokenEntity token) =>
      _repository.saveDeviceToken(token);
}
