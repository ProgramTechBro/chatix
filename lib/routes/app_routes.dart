class AppRoutes {
  AppRoutes._();

  static const String splash = '/splash';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String chats = '/chats';
  static const String postDetail = '/post-detail/:postId';

  static String postDetailPath(String postId) => '/post-detail/$postId';
}
