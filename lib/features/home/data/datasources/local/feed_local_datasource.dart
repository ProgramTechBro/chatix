import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/post_model.dart';

abstract class FeedLocalDataSource {
  Future<List<PostModel>> getFeedPosts();
  Future<PostModel> toggleLike(String postId);
}

@LazySingleton(as: FeedLocalDataSource)
class FeedLocalDataSourceImpl implements FeedLocalDataSource {
  final List<PostModel> _posts = [
    const PostModel(
      id: '1',
      authorId: 'u1',
      authorName: 'Mike tyson',
      authorAvatarUrl: AppNetworkImages.postAuthorMikeTyson,
      isVerified: true,
      postedAgo: '17h',
      caption: "I don't care who is doing better than me\nI am doing better than I was...",
      imageAsset: AppImages.feedPost1,
      likeCount: 980000,
      commentCount: 1200000,
      shareCount: 23000,
      isLiked: true,
    ),
    const PostModel(
      id: '2',
      authorId: 'u_bitcoin',
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

  @override
  Future<List<PostModel>> getFeedPosts() async => List.unmodifiable(_posts);

  @override
  Future<PostModel> toggleLike(String postId) async {
    final index = _posts.indexWhere((post) => post.id == postId);
    final current = _posts[index];
    final updated = PostModel(
      id: current.id,
      authorId: current.authorId,
      authorName: current.authorName,
      authorAvatarUrl: current.authorAvatarUrl,
      isVerified: current.isVerified,
      postedAgo: current.postedAgo,
      caption: current.caption,
      imageAsset: current.imageAsset,
      likeCount: current.isLiked ? current.likeCount - 1 : current.likeCount + 1,
      commentCount: current.commentCount,
      shareCount: current.shareCount,
      isLiked: !current.isLiked,
      mediaType: current.mediaType,
      videoUrl: current.videoUrl,
    );
    _posts[index] = updated;
    return updated;
  }
}
