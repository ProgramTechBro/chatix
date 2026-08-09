import 'package:bot_toast/bot_toast.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/presentation/screens/enter_name_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/otp_screen.dart';
import '../features/auth/presentation/screens/phone_verification_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import '../features/chat/presentation/screens/chat_screen.dart';
import '../features/chat_list/presentation/screens/chat_list_screen.dart';
import '../features/connections/presentation/screens/followers_screen.dart';
import '../features/connections/presentation/screens/following_screen.dart';
import '../features/home/presentation/screens/create_post_screen.dart';
import '../features/home/presentation/screens/post_detail_screen.dart';
import '../features/home/presentation/screens/report_post_screen.dart';
import '../features/main/presentation/screens/main_screen.dart';
import '../features/profile/presentation/screens/edit_profile_screen.dart';
import '../features/profile/presentation/screens/profile_posts_feed_screen.dart';
import '../features/profile/presentation/screens/profile_posts_grid_screen.dart';
import '../features/profile/presentation/screens/profile_screen.dart';
import '../features/search/presentation/screens/search_screen.dart';
import '../features/splash/presentation/screens/splash_screen.dart';
import '../features/videos/domain/entities/video_entity.dart';
import '../features/videos/presentation/screens/video_player_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  observers: [BotToastNavigatorObserver()],
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.welcome,
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: AppRoutes.chats,
      builder: (context, state) => const ChatListScreen(),
    ),
    GoRoute(
      path: AppRoutes.postDetail,
      builder: (context, state) =>
          PostDetailScreen(postId: state.pathParameters['postId']!),
    ),
    GoRoute(
      path: AppRoutes.reportPost,
      builder: (context, state) =>
          ReportPostScreen(postId: state.pathParameters['postId']!),
    ),
    GoRoute(
      path: AppRoutes.search,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) =>
          ProfileScreen(userId: state.pathParameters['userId']!),
    ),
    GoRoute(
      path: AppRoutes.videoPlayer,
      builder: (context, state) {
        final extra = state.extra! as Map<String, Object?>;
        return VideoPlayerScreen(
          videos: extra['videos']! as List<VideoEntity>,
          initialIndex: extra['initialIndex']! as int,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.createPost,
      builder: (context, state) => const CreatePostScreen(),
    ),
    GoRoute(
      path: AppRoutes.chatDetail,
      builder: (context, state) =>
          ChatScreen(conversationId: state.pathParameters['conversationId']!),
    ),
    GoRoute(
      path: AppRoutes.profilePostsFeed,
      builder: (context, state) =>
          ProfilePostsFeedScreen(userId: state.pathParameters['userId']!),
    ),
    GoRoute(
      path: AppRoutes.profilePostsGrid,
      builder: (context, state) =>
          ProfilePostsGridScreen(userId: state.pathParameters['userId']!),
    ),
    GoRoute(
      path: AppRoutes.editProfile,
      builder: (context, state) =>
          EditProfileScreen(userId: state.pathParameters['userId']!),
    ),
    GoRoute(
      path: AppRoutes.following,
      builder: (context, state) =>
          FollowingScreen(userId: state.pathParameters['userId']!),
    ),
    GoRoute(
      path: AppRoutes.followers,
      builder: (context, state) =>
          FollowersScreen(userId: state.pathParameters['userId']!),
    ),
    GoRoute(
      path: AppRoutes.phoneVerification,
      builder: (context, state) => const PhoneVerificationScreen(),
    ),
    GoRoute(
      path: AppRoutes.otpVerification,
      builder: (context, state) {
        final extra = state.extra! as Map<String, Object?>;
        return OtpScreen(phoneNumber: extra['phoneNumber']! as String);
      },
    ),
    GoRoute(
      path: AppRoutes.enterName,
      builder: (context, state) => const EnterNameScreen(),
    ),
  ],
);
