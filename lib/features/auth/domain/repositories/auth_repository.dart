import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../params/email_auth_params.dart';
import '../params/phone_otp_params.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signInWithEmail(EmailAuthParams params);

  Future<Either<Failure, UserEntity>> signUpWithEmail(EmailAuthParams params);

  Future<Either<Failure, String>> verifyPhoneNumber(String phoneNumber);

  Future<Either<Failure, ({UserEntity user, bool isNewUser})>> confirmPhoneOtp(
    PhoneOtpParams params,
  );

  Future<Either<Failure, UserEntity?>> restoreSession();

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, void>> updateLastSeen();

  Future<Either<Failure, void>> setOffline();

  Future<Either<Failure, void>> updateDisplayName(String name);
}
