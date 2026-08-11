import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
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
  final recent = chats.take(_recentConversationsPrefetchLimit);
  await Future.wait([
    for (final chat in recent) ...[
      ref.read(chatMessagesProvider(chat.id).future),
      ref.read(chatHeaderProvider(chat.id).future),
    ],
  ]);
  return chats;
}
