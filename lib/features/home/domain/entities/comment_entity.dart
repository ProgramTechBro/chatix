class CommentEntity {
  const CommentEntity({
    required this.id,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.postedAgo,
    required this.message,
    required this.likeCount,
  });

  final String id;
  final String authorName;
  final String authorAvatarUrl;
  final String postedAgo;
  final String message;
  final int likeCount;
}
