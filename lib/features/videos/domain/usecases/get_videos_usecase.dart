import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../data/repo/videos_repository.dart';
import '../entities/video_entity.dart';

@injectable
class GetVideosUseCase {
  const GetVideosUseCase(this._repository);

  final VideosRepository _repository;

  Future<Either<Failure, List<VideoEntity>>> call() => _repository.getVideos();
}
