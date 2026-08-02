import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/comment_entity.dart';
import '../repositories/comments_repository.dart';

@injectable
class GetPostCommentsUseCase {
  const GetPostCommentsUseCase(this._repository);

  final CommentsRepository _repository;

  Future<Either<Failure, List<CommentEntity>>> call(String postId) =>
      _repository.getComments(postId);
}
