import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../../../home/data/models/post_model.dart';
import '../../models/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<ProfileModel> getProfile(String userId);
  Future<List<PostModel>> getProfilePosts(String userId);
  Future<List<String>> getProfilePhotos(String userId);
}

@LazySingleton(as: ProfileLocalDataSource)
class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  @override
  Future<ProfileModel> getProfile(String userId) async {
    return const ProfileModel(
      id: 'u_johana',
      name: 'Johana West',
      bio: 'Hello my name is Johana west\nI am from Canada...',
      avatarAsset: AppImages.profileAvatar,
      coverAsset: AppImages.profileCover,
      followingCount: 23000,
      followersCount: 635000,
      postsCount: 102,
    );
  }

  @override
  Future<List<PostModel>> getProfilePosts(String userId) async {
    return const [
      PostModel(
        id: 'p_profile_1',
        authorId: 'u_johana',
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        isVerified: false,
        postedAgo: '17h',
        caption: "I don't care who is doing better than me\nI am doing better than I was...",
        imageAsset: AppImages.feedPost1,
        likeCount: 980000,
        commentCount: 1200000,
        shareCount: 23000,
        isLiked: false,
      ),
    ];
  }

  @override
  Future<List<String>> getProfilePhotos(String userId) async {
    return const [
      AppImages.profilePhoto1,
      AppImages.profilePhoto2,
      AppImages.profilePhoto3,
      AppImages.profilePhoto4,
      AppImages.profilePhoto5,
      AppImages.profilePhoto6,
    ];
  }
}
