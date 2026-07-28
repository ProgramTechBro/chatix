import 'package:injectable/injectable.dart';
import '../../data/repo/chat_repository.dart';
import '../entities/message_entity.dart';

@injectable
class WatchMessagesUseCase {
  const WatchMessagesUseCase(this._repository);

  final ChatRepository _repository;

  Stream<List<MessageEntity>> call(String chatId) => _repository.watchMessages(chatId);
}
