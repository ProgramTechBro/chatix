import 'package:flutter/material.dart';
import '../routes/app_pages.dart';
import 'theme/app_theme.dart';

class ChatixApp extends StatelessWidget {
  const ChatixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Chatix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
    );
  }
}
