import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/post_entity.dart';

abstract class FeedRepository {
  Future<Either<Failure, List<PostEntity>>> getFeedPosts();
}
