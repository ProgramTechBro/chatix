import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/feed_repository.dart';
import '../entities/post_entity.dart';

@injectable
class ToggleLikePostUseCase {
  const ToggleLikePostUseCase(this._repository);

  final FeedRepository _repository;

  Future<Either<Failure, PostEntity>> call(String postId) => _repository.toggleLikePost(postId);
}
