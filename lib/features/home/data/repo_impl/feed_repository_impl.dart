import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/post_entity.dart';
import '../datasources/local/feed_local_datasource.dart';
import '../repo/feed_repository.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  const FeedRepositoryImpl(this._localDataSource);

  final FeedLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<PostEntity>>> getFeedPosts() async {
    final posts = await _localDataSource.getFeedPosts();
    return Right(posts);
  }
}
