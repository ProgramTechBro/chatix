import 'dart:developer' as developer;

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../features/notifications/data/datasources/local/pending_message_local_datasource.dart';
import '../../features/notifications/data/datasources/local/pending_message_local_datasource_impl.dart';
import '../../features/notifications/data/models/pending_message_model.dart';
import '../../routes/app_pages.dart';
import '../../routes/app_routes.dart';
import '../constants/hive_boxes.dart';
import '../di/injector.dart';
import '../enums/message_type.dart';
import '../utils/helpers/stable_hash.dart';
import 'active_conversation_tracker.dart';

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
  await Hive.initFlutter();
  if (!Hive.isBoxOpen(HiveBoxes.pendingMessagesCache)) {
    await Hive.openBox<String>(HiveBoxes.pendingMessagesCache);
  }
  await PushNotificationService.handleMessage(
    message,
    pendingStore: PendingMessageLocalDataSourceImpl(),
  );
}

@pragma('vm:entry-point')
Future<void> onNotificationActionReceived(ReceivedAction action) async {
  final conversationId = action.payload?['conversationId'];
  if (conversationId != null) {
    appRouter.push(AppRoutes.chatDetailPath(conversationId));
  }
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

    final isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      await AwesomeNotifications().requestPermissionToSendNotifications();
    }

    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: onNotificationActionReceived,
    );
    final initialAction = await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
    if (initialAction != null) {
      await onNotificationActionReceived(initialAction);
    }

    FirebaseMessaging.onMessage.listen(
      (message) => handleMessage(
        message,
        pendingStore: getIt<PendingMessageLocalDataSource>(),
        activeConversationId: getIt<ActiveConversationTracker>().current,
      ),
    );
  }

  Future<String?> getToken() => _firebaseMessaging.getToken();

  Stream<String> get onTokenRefresh => _firebaseMessaging.onTokenRefresh;

  Future<void> clearNotification(String conversationId) {
    return AwesomeNotifications().cancel(stableHash(conversationId));
  }

  static Future<void> handleMessage(
    RemoteMessage message, {
    required PendingMessageLocalDataSource pendingStore,
    String? activeConversationId,
  }) async {
    final data = message.data;
    final conversationId = data['conversationId'] as String?;
    if (conversationId == null || conversationId == activeConversationId) {
      return;
    }

    final senderName = data['senderName'] as String? ?? 'New message';
    final senderAvatarUrl = data['senderAvatarUrl'] as String? ?? '';
    final preview =
        data['preview'] as String? ??
        message.notification?.body ??
        'Sent you a message';
    final type =
        MessageType.values.asNameMap()[data['type']] ?? MessageType.text;
    final mediaUrl = data['mediaUrl'] as String?;
    final createdAt =
        DateTime.tryParse(data['createdAt'] as String? ?? '') ?? DateTime.now();
    final rawMessageId = data['messageId'] as String?;
    final messageId = (rawMessageId != null && rawMessageId.isNotEmpty)
        ? rawMessageId
        : 'fallback-${DateTime.now().microsecondsSinceEpoch}';

    await pendingStore.add(
      conversationId,
      PendingMessageModel(
        messageId: messageId,
        senderName: senderName,
        senderAvatarUrl: senderAvatarUrl,
        preview: preview,
        createdAt: createdAt,
        type: type,
        mediaUrl: mediaUrl,
      ),
    );
    await Future.delayed(const Duration(milliseconds: 300));
    final pending = await pendingStore.getAll(conversationId);

    await _buildNotification(
      conversationId: conversationId,
      senderName: senderName,
      senderAvatarUrl: senderAvatarUrl,
      pending: pending,
    );
  }

  static Future<void> _buildNotification({
    required String conversationId,
    required String senderName,
    required String senderAvatarUrl,
    required List<PendingMessageModel> pending,
  }) {
    final id = stableHash(conversationId);
    developer.log(
      'Building notification: conversationId=$conversationId id=$id '
      'pendingCount=${pending.length} '
      'messageIds=${pending.map((message) => message.messageId).toList()}',
      name: 'chatix',
    );
    final largeIcon = senderAvatarUrl.isNotEmpty ? senderAvatarUrl : null;
    final singleImage =
        pending.length == 1 && pending.first.type == MessageType.image
        ? pending.first
        : null;
    final singleImageUrl = singleImage?.mediaUrl;

    if (singleImageUrl != null && singleImageUrl.isNotEmpty) {
      return AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: _chatChannelKey,
          title: senderName,
          body: 'Sent a photo',
          bigPicture: singleImageUrl,
          largeIcon: largeIcon,
          notificationLayout: NotificationLayout.BigPicture,
          payload: {'conversationId': conversationId},
        ),
      );
    }

    return AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: _chatChannelKey,
        title: senderName,
        body: pending.map((message) => message.preview).join('\n'),
        largeIcon: largeIcon,
        notificationLayout: NotificationLayout.MessagingGroup,
        payload: {'conversationId': conversationId},
      ),
    );
  }
}
