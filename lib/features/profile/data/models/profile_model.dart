import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.bio,
    required super.avatarAsset,
    required super.coverAsset,
    required super.followingCount,
    required super.followersCount,
    required super.postsCount,
  });
}
