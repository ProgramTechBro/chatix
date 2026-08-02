import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/video_entity.dart';

abstract class VideosRepository {
  Future<Either<Failure, List<VideoEntity>>> getVideos();
}
