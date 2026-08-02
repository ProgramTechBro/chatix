import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/post_entity.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<PostEntity>>> getFeedPosts();
  Future<Either<Failure, PostEntity>> toggleLikePost(String postId);
}
