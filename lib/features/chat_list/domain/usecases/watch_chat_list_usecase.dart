import 'package:injectable/injectable.dart';
import '../entities/chat_summary_entity.dart';
import '../repositories/chat_list_repository.dart';

@injectable
class WatchChatListUseCase {
  const WatchChatListUseCase(this._repository);

  final ChatListRepository _repository;

  Stream<List<ChatSummaryEntity>> call() => _repository.watchChatList();
}
