import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

@injectable
class VerifyPhoneNumberUseCase {
  const VerifyPhoneNumberUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, String>> call(String phoneNumber) {
    return _repository.verifyPhoneNumber(phoneNumber);
  }
}
