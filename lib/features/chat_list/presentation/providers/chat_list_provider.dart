import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/painting.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/message_type.dart';
import '../../../chat/domain/entities/message_entity.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
import '../../domain/entities/chat_summary_entity.dart';
import '../../domain/usecases/watch_chat_list_usecase.dart';

part 'chat_list_provider.g.dart';

const _recentConversationsPrefetchLimit = 30;

@Riverpod(keepAlive: true)
Stream<List<ChatSummaryEntity>> chatList(ChatListRef ref) {
  return getIt<WatchChatListUseCase>().call();
}

@Riverpod(keepAlive: true)
Future<List<ChatSummaryEntity>> chatListReady(ChatListReadyRef ref) async {
  final chats = await ref.read(chatListProvider.future);
  final recent = chats.take(_recentConversationsPrefetchLimit).toList();

  final messageLists = await Future.wait([
    for (final chat in recent) ref.read(chatMessagesProvider(chat.id).future),
  ]);

  await Future.wait([
    for (final chat in recent) ref.read(chatHeaderProvider(chat.id).future),
    for (final messages in messageLists) ...prefetchImageBytes(messages),
  ]);

  for (final chat in recent) {
    _watchForNewImages(ref, chat.id);
  }

  return chats;
}

void _watchForNewImages(ChatListReadyRef ref, String conversationId) {
  ref.listen(chatMessagesProvider(conversationId), (previous, next) {
    next.whenData((messages) {
      final previousIds =
          previous?.valueOrNull?.map((message) => message.id).toSet() ??
          const {};
      final newMessages = messages
          .where((message) => !previousIds.contains(message.id))
          .toList();
      prefetchImageBytes(newMessages);
    });
  });
}

Future<void> _precacheImage(String url) {
  final stream = CachedNetworkImageProvider(
    url,
  ).resolve(const ImageConfiguration());
  final completer = Completer<void>();
  late final ImageStreamListener listener;
  listener = ImageStreamListener(
    (image, synchronousCall) {
      completer.complete();
      stream.removeListener(listener);
    },
    onError: (error, stackTrace) {
      completer.complete();
      stream.removeListener(listener);
    },
  );
  stream.addListener(listener);
  return completer.future;
}

List<Future<void>> prefetchImageBytes(List<MessageEntity> messages) {
  return [
    for (final message in messages)
      if (message.type == MessageType.image && message.mediaUrl != null)
        _precacheImage(message.mediaUrl!),
  ];
}
