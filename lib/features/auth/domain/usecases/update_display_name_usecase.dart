import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

@injectable
class UpdateDisplayNameUseCase {
  const UpdateDisplayNameUseCase(this._repository);

  final AuthRepository _repository;

  Future<Either<Failure, void>> call(String name) {
    return _repository.updateDisplayName(name);
  }
}
