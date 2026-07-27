import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/video_model.dart';

abstract class VideosLocalDataSource {
  Future<List<VideoModel>> getVideos();
}

@LazySingleton(as: VideosLocalDataSource)
class VideosLocalDataSourceImpl implements VideosLocalDataSource {
  static const _base = 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample';

  @override
  Future<List<VideoModel>> getVideos() async {
    return const [
      VideoModel(
        id: 'v1',
        videoUrl: '$_base/BigBuckBunny.mp4',
        thumbnailAsset: AppImages.videoThumb1,
        authorName: 'Johana West',
        caption: 'Behind the scenes with the crew',
        likeCount: 12500,
      ),
      VideoModel(
        id: 'v2',
        videoUrl: '$_base/ForBiggerBlazes.mp4',
        thumbnailAsset: AppImages.videoThumb2,
        authorName: 'Johana West',
        caption: 'Chasing sunsets on set',
        likeCount: 8300,
      ),
      VideoModel(
        id: 'v3',
        videoUrl: '$_base/ForBiggerEscapes.mp4',
        thumbnailAsset: AppImages.videoThumb3,
        authorName: 'Johana West',
        caption: 'Golden hour shoot day',
        likeCount: 15100,
      ),
      VideoModel(
        id: 'v4',
        videoUrl: '$_base/ForBiggerFun.mp4',
        thumbnailAsset: AppImages.videoThumb4,
        authorName: 'Johana West',
        caption: 'Late night editing sessions',
        likeCount: 6400,
      ),
      VideoModel(
        id: 'v5',
        videoUrl: '$_base/Sintel.mp4',
        thumbnailAsset: AppImages.videoThumb5,
        authorName: 'Johana West',
        caption: 'New gear day!',
        likeCount: 9800,
      ),
      VideoModel(
        id: 'v6',
        videoUrl: '$_base/ElephantsDream.mp4',
        thumbnailAsset: AppImages.videoThumb6,
        authorName: 'Johana West',
        caption: 'Stage lighting rehearsal',
        likeCount: 11200,
      ),
    ];
  }
}
