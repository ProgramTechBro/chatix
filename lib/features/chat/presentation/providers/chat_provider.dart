import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/chat_header_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/watch_conversation_header_usecase.dart';
import '../../domain/usecases/watch_messages_usecase.dart';

part 'chat_provider.g.dart';

const _cacheDuration = Duration(minutes: 5);

@riverpod
Stream<List<MessageEntity>> chatMessages(
  ChatMessagesRef ref,
  String conversationId,
) {
  final link = ref.keepAlive();
  Timer? timer;
  ref.onDispose(() => timer?.cancel());
  ref.onCancel(() => timer = Timer(_cacheDuration, link.close));
  ref.onResume(() => timer?.cancel());
  return getIt<WatchMessagesUseCase>().call(conversationId);
}

@riverpod
Stream<ChatHeaderEntity> chatHeader(ChatHeaderRef ref, String conversationId) {
  final link = ref.keepAlive();
  Timer? timer;
  ref.onDispose(() => timer?.cancel());
  ref.onCancel(() => timer = Timer(_cacheDuration, link.close));
  ref.onResume(() => timer?.cancel());
  return getIt<WatchConversationHeaderUseCase>().call(conversationId);
}
