class VideoEntity {
  const VideoEntity({
    required this.id,
    required this.videoUrl,
    required this.thumbnailAsset,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.saveCount,
  });

  final String id;
  final String videoUrl;
  final String thumbnailAsset;
  final String authorName;
  final String authorAvatarUrl;
  final String caption;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final int saveCount;
}
