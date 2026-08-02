import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../params/phone_otp_params.dart';
import '../repositories/auth_repository.dart';

@injectable
class ConfirmPhoneOtpUseCase {
  const ConfirmPhoneOtpUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, UserEntity>> call(PhoneOtpParams params) {
    return _repository.confirmPhoneOtp(params);
  }
}
