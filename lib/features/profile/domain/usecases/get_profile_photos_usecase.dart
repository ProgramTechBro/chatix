import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/profile_repository.dart';

@injectable
class GetProfilePhotosUseCase {
  const GetProfilePhotosUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, List<String>>> call(String userId) => _repository.getProfilePhotos(userId);
}
