import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/usecases/get_videos_usecase.dart';

part 'videos_provider.g.dart';

@riverpod
Future<List<VideoEntity>> videos(VideosRef ref) async {
  final result = await getIt<GetVideosUseCase>().call();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (videos) => videos,
  );
}
