class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String chats = '/chats';
  static const String postDetail = '/post-detail/:postId';
  static const String reportPost = '/report/:postId';
  static const String search = '/search';
  static const String profile = '/profile/:userId';
  static const String videoPlayer = '/video-player';
  static const String createPost = '/create-post';
  static const String chatDetail = '/chat-detail';
  static const String profilePostsFeed = '/profile-posts/:userId';

  static String postDetailPath(String postId) => '/post-detail/$postId';
  static String reportPostPath(String postId) => '/report/$postId';
  static String profilePath(String userId) => '/profile/$userId';
  static String profilePostsFeedPath(String userId) => '/profile-posts/$userId';
}
