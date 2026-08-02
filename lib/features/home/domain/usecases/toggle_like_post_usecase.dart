import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';
import '../repositories/feed_repository.dart';

@injectable
class ToggleLikePostUseCase {
  const ToggleLikePostUseCase(this._repository);

  final FeedRepository _repository;

  Future<Either<Failure, PostEntity>> call(String postId) =>
      _repository.toggleLikePost(postId);
}
