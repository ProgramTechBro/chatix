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
        authorName: 'Jerry kovet',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        caption: 'how to do wood art #art',
        likeCount: 293000,
        commentCount: 20900,
        shareCount: 29000,
        saveCount: 9800,
      ),
      VideoModel(
        id: 'v2',
        videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        thumbnailAsset: AppImages.videoThumb2,
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        caption: 'Chasing sunsets on set',
        likeCount: 8300,
        commentCount: 412,
        shareCount: 620,
        saveCount: 210,
      ),
      VideoModel(
        id: 'v3',
        videoUrl: 'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4',
        thumbnailAsset: AppImages.videoThumb3,
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        caption: 'Golden hour shoot day',
        likeCount: 15100,
        commentCount: 730,
        shareCount: 940,
        saveCount: 380,
      ),
      VideoModel(
        id: 'v4',
        videoUrl: 'https://www.w3schools.com/html/mov_bbb.mp4',
        thumbnailAsset: AppImages.videoThumb4,
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        caption: 'Late night editing sessions',
        likeCount: 6400,
        commentCount: 260,
        shareCount: 310,
        saveCount: 140,
      ),
      VideoModel(
        id: 'v5',
        videoUrl: 'https://media.w3.org/2010/05/sintel/trailer.mp4',
        thumbnailAsset: AppImages.videoThumb5,
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        caption: 'New gear day!',
        likeCount: 9800,
        commentCount: 405,
        shareCount: 520,
        saveCount: 190,
      ),
      VideoModel(
        id: 'v6',
        videoUrl: 'https://media.w3.org/2010/05/bunny/movie.mp4',
        thumbnailAsset: AppImages.videoThumb6,
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        caption: 'Stage lighting rehearsal',
        likeCount: 11200,
        commentCount: 580,
        shareCount: 690,
        saveCount: 260,
      ),
    ];
  }
}
