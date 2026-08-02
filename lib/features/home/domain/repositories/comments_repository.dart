import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/comment_entity.dart';

abstract class CommentsRepository {
  Future<Either<Failure, List<CommentEntity>>> getComments(String postId);
}
