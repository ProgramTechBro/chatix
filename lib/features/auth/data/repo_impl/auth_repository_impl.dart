import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repo/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<Either<Failure, void>> sendOtp(String phoneNumber) async => const Right(null);

  @override
  Future<Either<Failure, void>> verifyOtp(String code) async => const Right(null);
}
