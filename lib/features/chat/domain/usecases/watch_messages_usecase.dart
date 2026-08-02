import 'package:injectable/injectable.dart';
import '../entities/message_entity.dart';
import '../repositories/chat_repository.dart';

@injectable
class WatchMessagesUseCase {
  const WatchMessagesUseCase(this._repository);

  final ChatRepository _repository;

  Stream<List<MessageEntity>> call(String conversationId) {
    return _repository.watchMessages(conversationId);
  }
}
