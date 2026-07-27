import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/post_entity.dart';
import '../../data/repo/profile_repository.dart';

@injectable
class GetProfilePostsUseCase {
  const GetProfilePostsUseCase(this._repository);

  final ProfileRepository _repository;

  Future<Either<Failure, List<PostEntity>>> call(String userId) => _repository.getProfilePosts(userId);
}
