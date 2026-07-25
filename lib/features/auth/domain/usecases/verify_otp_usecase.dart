import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/auth_repository.dart';

@injectable
class VerifyOtpUseCase {
  final AuthRepository repository;
  const VerifyOtpUseCase(this.repository);

  Future<Either<Failure, void>> call(String code) => repository.verifyOtp(code);
}
