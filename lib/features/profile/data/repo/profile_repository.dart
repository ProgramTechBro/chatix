import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../home/domain/entities/post_entity.dart';
import '../../domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> getProfile(String userId);
  Future<Either<Failure, List<PostEntity>>> getProfilePosts(String userId);
  Future<Either<Failure, List<String>>> getProfilePhotos(String userId);
}
