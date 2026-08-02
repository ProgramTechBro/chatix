import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../params/email_auth_params.dart';
import '../repositories/auth_repository.dart';

@injectable
class SignInWithEmailUseCase {
  const SignInWithEmailUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, UserEntity>> call(EmailAuthParams params) {
    return _repository.signInWithEmail(params);
  }
}
