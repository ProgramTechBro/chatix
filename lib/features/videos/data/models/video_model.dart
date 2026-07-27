import '../../domain/entities/video_entity.dart';

class VideoModel extends VideoEntity {
  const VideoModel({
    required super.id,
    required super.videoUrl,
    required super.thumbnailAsset,
    required super.authorName,
    required super.caption,
    required super.likeCount,
  });
}
