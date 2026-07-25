import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

class ChatixApp extends StatelessWidget {
  const ChatixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const _AppRoot(),
    );
  }
}

class _AppRoot extends StatelessWidget {
  const _AppRoot();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Chatix'),
      ),
    );
  }
}
