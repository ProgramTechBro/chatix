class VideoEntity {
  const VideoEntity({
    required this.id,
    required this.videoUrl,
    required this.thumbnailAsset,
    required this.authorName,
    required this.caption,
    required this.likeCount,
  });

  final String id;
  final String videoUrl;
  final String thumbnailAsset;
  final String authorName;
  final String caption;
  final int likeCount;
}
