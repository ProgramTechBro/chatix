import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../home/domain/entities/post_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/usecases/get_profile_photos_usecase.dart';
import '../../domain/usecases/get_profile_posts_usecase.dart';
import '../../domain/usecases/get_profile_usecase.dart';

part 'profile_provider.g.dart';

@riverpod
Future<ProfileEntity> profile(ProfileRef ref, String userId) async {
  final result = await getIt<GetProfileUseCase>().call(userId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (profile) => profile,
  );
}

@riverpod
Future<List<PostEntity>> profilePosts(ProfilePostsRef ref, String userId) async {
  final result = await getIt<GetProfilePostsUseCase>().call(userId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (posts) => posts,
  );
}

@riverpod
Future<List<String>> profilePhotos(ProfilePhotosRef ref, String userId) async {
  final result = await getIt<GetProfilePhotosUseCase>().call(userId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (photos) => photos,
  );
}
