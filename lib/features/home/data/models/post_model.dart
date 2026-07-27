import '../../domain/entities/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.id,
    required super.authorId,
    required super.authorName,
    required super.authorAvatarUrl,
    required super.isVerified,
    required super.postedAgo,
    required super.caption,
    required super.imageAsset,
    required super.likeCount,
    required super.commentCount,
    required super.shareCount,
    required super.isLiked,
  });
}
