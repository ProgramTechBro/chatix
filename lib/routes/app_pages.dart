import 'package:go_router/go_router.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/auth/presentation/welcome_screen.dart';
import '../features/chat_list/presentation/chat_list_screen.dart';
import '../features/home/presentation/post_detail_screen.dart';
import '../features/home/presentation/report_post_screen.dart';
import '../features/main/presentation/main_screen.dart';
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
  ],
);
