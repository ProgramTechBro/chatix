import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/chat_summary_entity.dart';
import '../../domain/usecases/get_chat_list_usecase.dart';

part 'chat_list_provider.g.dart';

@riverpod
Future<List<ChatSummaryEntity>> chatList(ChatListRef ref) async {
  final result = await getIt<GetChatListUseCase>().call();
  return result.fold(
    (failure) => throw Exception(failure.message),
    (chats) => chats,
  );
}
