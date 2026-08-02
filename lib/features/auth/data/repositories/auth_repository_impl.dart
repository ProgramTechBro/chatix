import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/logger_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/params/email_auth_params.dart';
import '../../domain/params/phone_otp_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/firebase_phone_auth_remote_datasource.dart';
import '../datasources/remote/supabase_auth_remote_datasource.dart';
import '../mappers/firebase_auth_error_mapper.dart';
import '../mappers/supabase_auth_error_mapper.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(
    this._supabaseDataSource,
    this._firebaseDataSource,
    this._logger,
  );

  final SupabaseAuthRemoteDataSource _supabaseDataSource;
  final FirebasePhoneAuthRemoteDataSource _firebaseDataSource;
  final LoggerService _logger;

  @override
  Future<Either<Failure, UserEntity>> signInWithEmail(
    EmailAuthParams params,
  ) async {
    try {
      final user = await _supabaseDataSource.signInWithEmail(
        params.email,
        params.password,
      );
      return Right(user);
    } catch (error, stackTrace) {
      _logger.logError(error, stackTrace);
      return Left(mapSupabaseAuthError(error));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail(
    EmailAuthParams params,
  ) async {
    try {
      final user = await _supabaseDataSource.signUpWithEmail(
        email: params.email,
        password: params.password,
        name: params.name ?? '',
      );
      return Right(user);
    } catch (error, stackTrace) {
      _logger.logError(error, stackTrace);
      return Left(mapSupabaseAuthError(error));
    }
  }

  @override
  Future<Either<Failure, String>> verifyPhoneNumber(String phoneNumber) async {
    try {
      final verificationId = await _firebaseDataSource.verifyPhoneNumber(
        phoneNumber,
      );
      return Right(verificationId);
    } catch (error, stackTrace) {
      _logger.logError(error, stackTrace);
      return Left(mapFirebaseAuthError(error));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> confirmPhoneOtp(
    PhoneOtpParams params,
  ) async {
    try {
      final idToken = await _firebaseDataSource.confirmOtp(
        params.verificationId,
        params.smsCode,
      );
      final user = await _supabaseDataSource.bridgePhoneAuth(
        phoneNumber: params.phoneNumber,
        firebaseIdToken: idToken,
        name: params.name,
      );
      return Right(user);
    } on FirebaseAuthException catch (error, stackTrace) {
      _logger.logError(error, stackTrace);
      return Left(mapFirebaseAuthError(error));
    } catch (error, stackTrace) {
      _logger.logError(error, stackTrace);
      return Left(mapSupabaseAuthError(error));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> restoreSession() async {
    try {
      final user = await _supabaseDataSource.restoreSession();
      return Right(user);
    } catch (error, stackTrace) {
      _logger.logError(error, stackTrace);
      return const Left(AuthFailure('Could not restore session.'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _supabaseDataSource.setOffline();
      await _supabaseDataSource.signOut();
      return const Right(null);
    } catch (error, stackTrace) {
      _logger.logError(error, stackTrace);
      return const Left(AuthFailure('Sign out failed.'));
    }
  }

  @override
  Future<Either<Failure, void>> updateLastSeen() async {
    try {
      await _supabaseDataSource.updateLastSeen();
      return const Right(null);
    } catch (error, stackTrace) {
      _logger.logError(error, stackTrace);
      return const Left(AuthFailure('Could not update presence.'));
    }
  }

  @override
  Future<Either<Failure, void>> setOffline() async {
    try {
      await _supabaseDataSource.setOffline();
      return const Right(null);
    } catch (error, stackTrace) {
      _logger.logError(error, stackTrace);
      return const Left(AuthFailure('Could not update presence.'));
    }
  }
}
