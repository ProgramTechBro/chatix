import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/video_model.dart';

abstract class VideosLocalDataSource {
  Future<List<VideoModel>> getVideos();
}

@LazySingleton(as: VideosLocalDataSource)
class VideosLocalDataSourceImpl implements VideosLocalDataSource {
  @override
  Future<List<VideoModel>> getVideos() async {
    return const [
      VideoModel(
        id: 'v1',
        videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
        thumbnailAsset: AppImages.videoThumb1,
        authorName: 'Johana West',
        caption: 'Behind the scenes with the crew',
        likeCount: 12500,
      ),
      VideoModel(
        id: 'v2',
        videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        thumbnailAsset: AppImages.videoThumb2,
        authorName: 'Johana West',
        caption: 'Chasing sunsets on set',
        likeCount: 8300,
      ),
      VideoModel(
        id: 'v3',
        videoUrl: 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4',
        thumbnailAsset: AppImages.videoThumb3,
        authorName: 'Johana West',
        caption: 'Golden hour shoot day',
        likeCount: 15100,
      ),
      VideoModel(
        id: 'v4',
        videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
        thumbnailAsset: AppImages.videoThumb4,
        authorName: 'Johana West',
        caption: 'Late night editing sessions',
        likeCount: 6400,
      ),
      VideoModel(
        id: 'v5',
        videoUrl: 'https://media.w3.org/2010/05/sintel/trailer.mp4',
        thumbnailAsset: AppImages.videoThumb5,
        authorName: 'Johana West',
        caption: 'New gear day!',
        likeCount: 9800,
      ),
      VideoModel(
        id: 'v6',
        videoUrl: 'https://media.w3.org/2010/05/bunny/movie.mp4',
        thumbnailAsset: AppImages.videoThumb6,
        authorName: 'Johana West',
        caption: 'Stage lighting rehearsal',
        likeCount: 11200,
      ),
    ];
  }
}
