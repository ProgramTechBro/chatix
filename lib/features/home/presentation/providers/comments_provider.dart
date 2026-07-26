import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/comment_entity.dart';
import '../../domain/usecases/get_post_comments_usecase.dart';

part 'comments_provider.g.dart';

@riverpod
Future<List<CommentEntity>> postComments(PostCommentsRef ref, String postId) async {
  final result = await getIt<GetPostCommentsUseCase>().call(postId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (comments) => comments,
  );
}
