import 'package:go_router/go_router.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/auth/presentation/welcome_screen.dart';
import '../features/chat/presentation/chat_screen.dart';
import '../features/chat_list/domain/entities/chat_summary_entity.dart';
import '../features/chat_list/presentation/chat_list_screen.dart';
import '../features/connections/presentation/followers_screen.dart';
import '../features/connections/presentation/following_screen.dart';
import '../features/home/presentation/create_post_screen.dart';
import '../features/home/presentation/post_detail_screen.dart';
import '../features/home/presentation/report_post_screen.dart';
import '../features/main/presentation/main_screen.dart';
import '../features/profile/presentation/edit_profile_screen.dart';
import '../features/profile/presentation/profile_posts_feed_screen.dart';
import '../features/profile/presentation/profile_posts_grid_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/search/presentation/search_screen.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/videos/domain/entities/video_entity.dart';
import '../features/videos/presentation/video_player_screen.dart';
import 'app_routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
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
      builder: (context, state) => PostDetailScreen(postId: state.pathParameters['postId']!),
    ),
    GoRoute(
      path: AppRoutes.reportPost,
      builder: (context, state) => ReportPostScreen(postId: state.pathParameters['postId']!),
    ),
    GoRoute(
      path: AppRoutes.search,
      builder: (context, state) => const SearchScreen(),
    ),
    GoRoute(
      path: AppRoutes.profile,
      builder: (context, state) => ProfileScreen(userId: state.pathParameters['userId']!),
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
      builder: (context, state) => ChatScreen(chat: state.extra! as ChatSummaryEntity),
    ),
    GoRoute(
      path: AppRoutes.profilePostsFeed,
      builder: (context, state) => ProfilePostsFeedScreen(userId: state.pathParameters['userId']!),
    ),
    GoRoute(
      path: AppRoutes.profilePostsGrid,
      builder: (context, state) => ProfilePostsGridScreen(userId: state.pathParameters['userId']!),
    ),
    GoRoute(
      path: AppRoutes.editProfile,
      builder: (context, state) => EditProfileScreen(userId: state.pathParameters['userId']!),
    ),
    GoRoute(
      path: AppRoutes.following,
      builder: (context, state) => FollowingScreen(userId: state.pathParameters['userId']!),
    ),
    GoRoute(
      path: AppRoutes.followers,
      builder: (context, state) => FollowersScreen(userId: state.pathParameters['userId']!),
    ),
  ],
);
