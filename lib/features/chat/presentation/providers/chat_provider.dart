import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/chat_header_entity.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/watch_conversation_header_usecase.dart';
import '../../domain/usecases/watch_messages_usecase.dart';

part 'chat_provider.g.dart';

@riverpod
Stream<List<MessageEntity>> chatMessages(
  ChatMessagesRef ref,
  String conversationId,
) {
  return getIt<WatchMessagesUseCase>().call(conversationId);
}

@riverpod
Stream<ChatHeaderEntity> chatHeader(ChatHeaderRef ref, String conversationId) {
  return getIt<WatchConversationHeaderUseCase>().call(conversationId);
}
