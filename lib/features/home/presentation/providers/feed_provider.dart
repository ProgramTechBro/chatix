import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_feed_posts_usecase.dart';
import '../../domain/usecases/toggle_like_post_usecase.dart';

part 'feed_provider.g.dart';

@riverpod
class FeedController extends _$FeedController {
  @override
  Future<List<PostEntity>> build() async {
    final result = await getIt<GetFeedPostsUseCase>().call();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (posts) => posts,
    );
  }

  Future<void> toggleLike(String postId) async {
    final currentPosts = state.valueOrNull;
    if (currentPosts == null) return;

    final result = await getIt<ToggleLikePostUseCase>().call(postId);
    result.fold(
      (failure) => null,
      (updatedPost) {
        state = AsyncData([
          for (final post in currentPosts)
            if (post.id == updatedPost.id) updatedPost else post,
        ]);
      },
    );
  }
}
