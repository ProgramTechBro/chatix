import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../models/comment_model.dart';

abstract class CommentsLocalDataSource {
  Future<List<CommentModel>> getComments(String postId);
}

@LazySingleton(as: CommentsLocalDataSource)
class CommentsLocalDataSourceImpl implements CommentsLocalDataSource {
  final Map<String, List<CommentModel>> _commentsByPostId = {};

  @override
  Future<List<CommentModel>> getComments(String postId) async {
    return _commentsByPostId.putIfAbsent(
      postId,
      () => const [
        CommentModel(
          id: 'c1',
          authorName: 'Mike tyson',
          authorAvatarUrl: AppNetworkImages.postAuthorMikeTyson,
          postedAgo: '17h',
          message:
              'That is looking so amazing you know?\nI have also photo like you',
          likeCount: 980000,
        ),
        CommentModel(
          id: 'c2',
          authorName: 'Robert John',
          authorAvatarUrl: AppNetworkImages.postAuthorRobertJohn,
          postedAgo: '20min',
          message: 'Great man just amazing',
          likeCount: 980000,
        ),
      ],
    );
  }
}
