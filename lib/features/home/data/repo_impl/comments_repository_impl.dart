import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/comment_entity.dart';
import '../datasources/local/comments_local_datasource.dart';
import '../repo/comments_repository.dart';

@LazySingleton(as: CommentsRepository)
class CommentsRepositoryImpl implements CommentsRepository {
  const CommentsRepositoryImpl(this._localDataSource);

  final CommentsLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<CommentEntity>>> getComments(String postId) async {
    final comments = await _localDataSource.getComments(postId);
    return Right(List<CommentEntity>.of(comments));
  }
}
