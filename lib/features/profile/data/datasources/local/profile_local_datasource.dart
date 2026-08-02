import 'package:injectable/injectable.dart';
import '../../../../../config/app_assets.dart';
import '../../../../../core/enums/post_media_type.dart';
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
      birthDate: '27/07/2006',
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
        caption:
            "I don't care who is doing better than me\nI am doing better than I was...",
        imageAsset: AppImages.feedPost1,
        likeCount: 980000,
        commentCount: 1200000,
        shareCount: 23000,
        isLiked: false,
      ),
      PostModel(
        id: 'p_profile_2',
        authorId: 'u_johana',
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        isVerified: false,
        postedAgo: '2d',
        caption: 'Behind the scenes with the crew today',
        imageAsset: AppImages.videoThumb1,
        likeCount: 12500,
        commentCount: 340,
        shareCount: 1200,
        isLiked: false,
        mediaType: PostMediaType.video,
        videoUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
      PostModel(
        id: 'p_profile_3',
        authorId: 'u_johana',
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        isVerified: false,
        postedAgo: '4d',
        caption: 'Golden hour walk',
        imageAsset: AppImages.profilePhoto2,
        likeCount: 8300,
        commentCount: 210,
        shareCount: 90,
        isLiked: false,
      ),
      PostModel(
        id: 'p_profile_4',
        authorId: 'u_johana',
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        isVerified: false,
        postedAgo: '6d',
        caption: 'Chasing sunsets on set',
        imageAsset: AppImages.videoThumb3,
        likeCount: 15100,
        commentCount: 512,
        shareCount: 640,
        isLiked: false,
        mediaType: PostMediaType.video,
        videoUrl:
            'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
      PostModel(
        id: 'p_profile_5',
        authorId: 'u_johana',
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        isVerified: false,
        postedAgo: '1w',
        caption: 'Quiet mornings',
        imageAsset: AppImages.profilePhoto4,
        likeCount: 6400,
        commentCount: 180,
        shareCount: 45,
        isLiked: false,
      ),
      PostModel(
        id: 'p_profile_6',
        authorId: 'u_johana',
        authorName: 'Johana West',
        authorAvatarUrl: AppNetworkImages.contactJohannaWest,
        isVerified: false,
        postedAgo: '2w',
        caption: 'New gear day!',
        imageAsset: AppImages.videoThumb5,
        likeCount: 9800,
        commentCount: 275,
        shareCount: 130,
        isLiked: false,
        mediaType: PostMediaType.video,
        videoUrl:
            'https://interactive-examples.mdn.mozilla.net/media/cc0-videos/flower.mp4',
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
