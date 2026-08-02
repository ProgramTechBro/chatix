import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

const _chatChannelKey = 'chat_messages';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: _chatChannelKey,
      channelName: 'Chat messages',
      channelDescription: 'New message notifications',
      importance: NotificationImportance.High,
    ),
  ]);
  await PushNotificationService.showFromRemoteMessage(message);
}

@lazySingleton
class PushNotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initialize() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
        channelKey: _chatChannelKey,
        channelName: 'Chat messages',
        channelDescription: 'New message notifications',
        importance: NotificationImportance.High,
      ),
    ]);

    await _firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen(showFromRemoteMessage);
  }

  Future<String?> getToken() => _firebaseMessaging.getToken();

  Stream<String> get onTokenRefresh => _firebaseMessaging.onTokenRefresh;

  static Future<void> showFromRemoteMessage(RemoteMessage message) async {
    final data = message.data;
    final senderName = data['senderName'] as String? ?? 'New message';
    final senderAvatarUrl = data['senderAvatarUrl'] as String?;
    final body =
        data['preview'] as String? ??
        message.notification?.body ??
        'Sent you a message';

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(1 << 31),
        channelKey: _chatChannelKey,
        title: senderName,
        body: body,
        largeIcon: senderAvatarUrl,
        notificationLayout: senderAvatarUrl != null
            ? NotificationLayout.MessagingGroup
            : NotificationLayout.Default,
        payload: {
          if (data['conversationId'] != null)
            'conversationId': data['conversationId'] as String,
        },
      ),
    );
  }
}
