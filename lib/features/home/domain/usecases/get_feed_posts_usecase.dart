import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';
import '../repositories/feed_repository.dart';

@injectable
class GetFeedPostsUseCase {
  const GetFeedPostsUseCase(this._repository);

  final FeedRepository _repository;

  Future<Either<Failure, List<PostEntity>>> call() =>
      _repository.getFeedPosts();
}
