import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../entities/video_entity.dart';
import '../repositories/videos_repository.dart';

@injectable
class GetVideosUseCase {
  const GetVideosUseCase(this._repository);

  final VideosRepository _repository;

  Future<Either<Failure, List<VideoEntity>>> call() => _repository.getVideos();
}
