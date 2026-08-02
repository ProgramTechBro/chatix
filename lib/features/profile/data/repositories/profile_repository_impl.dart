import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/post_entity.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/local/profile_local_datasource.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this._localDataSource);

  final ProfileLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, ProfileEntity>> getProfile(String userId) async {
    final profile = await _localDataSource.getProfile(userId);
    return Right(profile);
  }

  @override
  Future<Either<Failure, List<PostEntity>>> getProfilePosts(
    String userId,
  ) async {
    final posts = await _localDataSource.getProfilePosts(userId);
    return Right(List<PostEntity>.of(posts));
  }

  @override
  Future<Either<Failure, List<String>>> getProfilePhotos(String userId) async {
    final photos = await _localDataSource.getProfilePhotos(userId);
    return Right(List<String>.of(photos));
  }
}
