import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/auth_repository.dart';

@injectable
class SendOtpUseCase {
  final AuthRepository repository;
  const SendOtpUseCase(this.repository);

  Future<Either<Failure, void>> call(String phoneNumber) => repository.sendOtp(phoneNumber);
}
