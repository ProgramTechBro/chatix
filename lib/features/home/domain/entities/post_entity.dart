class PostEntity {
  const PostEntity({
    required this.id,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.isVerified,
    required this.postedAgo,
    required this.caption,
    required this.imageAsset,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.isLiked,
  });

  final String id;
  final String authorName;
  final String authorAvatarUrl;
  final bool isVerified;
  final String postedAgo;
  final String caption;
  final String imageAsset;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final bool isLiked;
}
