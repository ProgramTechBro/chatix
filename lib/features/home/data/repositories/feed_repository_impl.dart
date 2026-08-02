import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/feed_repository.dart';
import '../datasources/local/feed_local_datasource.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  const FeedRepositoryImpl(this._localDataSource);

  final FeedLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<PostEntity>>> getFeedPosts() async {
    final posts = await _localDataSource.getFeedPosts();
    return Right(List<PostEntity>.of(posts));
  }

  @override
  Future<Either<Failure, PostEntity>> toggleLikePost(String postId) async {
    final post = await _localDataSource.toggleLike(postId);
    return Right(post);
  }
}
