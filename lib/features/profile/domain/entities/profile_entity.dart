class ProfileEntity {
  const ProfileEntity({
    required this.id,
    required this.name,
    required this.bio,
    required this.avatarAsset,
    required this.coverAsset,
    required this.followingCount,
    required this.followersCount,
    required this.postsCount,
  });

  final String id;
  final String name;
  final String bio;
  final String avatarAsset;
  final String coverAsset;
  final int followingCount;
  final int followersCount;
  final int postsCount;
}
