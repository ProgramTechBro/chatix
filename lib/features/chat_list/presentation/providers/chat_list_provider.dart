import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/chat_summary_entity.dart';
import '../../domain/usecases/watch_chat_list_usecase.dart';

part 'chat_list_provider.g.dart';

@Riverpod(keepAlive: true)
Stream<List<ChatSummaryEntity>> chatList(ChatListRef ref) {
  return getIt<WatchChatListUseCase>().call();
}
