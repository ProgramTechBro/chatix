import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/feed_repository.dart';
import '../entities/post_entity.dart';

@injectable
class GetFeedPostsUseCase {
  const GetFeedPostsUseCase(this._repository);

  final FeedRepository _repository;

  Future<Either<Failure, List<PostEntity>>> call() => _repository.getFeedPosts();
}
