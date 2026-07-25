import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/post_model.dart';

abstract class FeedLocalDataSource {
  Future<List<PostModel>> getFeedPosts();
}

@LazySingleton(as: FeedLocalDataSource)
class FeedLocalDataSourceImpl implements FeedLocalDataSource {
  @override
  Future<List<PostModel>> getFeedPosts() async {
    return const [
      PostModel(
        id: '1',
        authorName: 'Mike tyson',
        authorAvatarUrl: AppNetworkImages.postAuthorMikeTyson,
        isVerified: true,
        postedAgo: '17h',
        caption:
            "I don't care who is doing better than me\nI am doing better than I was...",
        imageAsset: AppImages.feedPost1,
        likeCount: 980000,
        commentCount: 1200000,
        shareCount: 23000,
        isLiked: true,
      ),
      PostModel(
        id: '2',
        authorName: 'Bitcoin',
        authorAvatarUrl: AppNetworkImages.postAuthorBitcoin,
        isVerified: true,
        postedAgo: '5d',
        caption: 'What do think Bitcoin is much worthier?\nno more good time than now...',
        imageAsset: AppImages.feedPost2,
        likeCount: 980000,
        commentCount: 1200000,
        shareCount: 23000,
        isLiked: false,
      ),
    ];
  }
}
