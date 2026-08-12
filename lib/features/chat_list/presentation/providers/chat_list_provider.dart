import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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

  return chats;
}

List<Future<void>> prefetchImageBytes(List<MessageEntity> messages) {
  return [
    for (final message in messages)
      if (message.type == MessageType.image && message.mediaUrl != null)
        DefaultCacheManager().getSingleFile(message.mediaUrl!),
  ];
}
