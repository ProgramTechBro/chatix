import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/chatix_app.dart';
import 'core/constants/hive_boxes.dart';
import 'core/di/injector.dart';
import 'core/services/push_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    publishableKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox<String>(HiveBoxes.chatListCache),
    Hive.openBox<String>(HiveBoxes.chatMessagesCache),
    Hive.openBox<String>(HiveBoxes.pendingMessagesCache),
    Hive.openBox<String>(HiveBoxes.chatHeaderCache),
  ]);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  configureDependencies();
  await getIt<PushNotificationService>().initialize();
  runApp(const ProviderScope(child: ChatixApp()));
}
