import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_feed_posts_usecase.dart';

part 'feed_provider.g.dart';

@riverpod
Future<List<PostEntity>> feedPosts(FeedPostsRef ref) async {
  final useCase = getIt<GetFeedPostsUseCase>();
  final result = await useCase();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (posts) => posts,
  );
}
