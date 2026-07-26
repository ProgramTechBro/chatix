import '../../domain/entities/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel({
    required super.id,
    required super.authorName,
    required super.authorAvatarUrl,
    required super.postedAgo,
    required super.message,
    required super.likeCount,
  });
}
