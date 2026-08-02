import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repositories/videos_repository.dart';
import '../datasources/local/videos_local_datasource.dart';

@LazySingleton(as: VideosRepository)
class VideosRepositoryImpl implements VideosRepository {
  const VideosRepositoryImpl(this._localDataSource);

  final VideosLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, List<VideoEntity>>> getVideos() async {
    final videos = await _localDataSource.getVideos();
    return Right(List<VideoEntity>.of(videos));
  }
}
