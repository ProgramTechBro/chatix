import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/theme/app_theme.dart';
import '../core/providers/auth/auth_provider.dart';
import '../routes/app_pages.dart';

class ChatixApp extends ConsumerStatefulWidget {
  const ChatixApp({super.key});

  @override
  ConsumerState<ChatixApp> createState() => _ChatixAppState();
}

class _ChatixAppState extends ConsumerState<ChatixApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final session = ref.read(sessionControllerProvider.notifier);
    switch (state) {
      case AppLifecycleState.resumed:
        session.onAppResumed();
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        session.onAppPaused();
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Chatix',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      routerConfig: appRouter,
      builder: BotToastInit(),
    );
  }
}
