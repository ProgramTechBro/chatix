import 'package:injectable/injectable.dart';
import '../entities/chat_header_entity.dart';
import '../repositories/chat_repository.dart';

@injectable
class WatchConversationHeaderUseCase {
  const WatchConversationHeaderUseCase(this._repository);

  final ChatRepository _repository;

  Stream<ChatHeaderEntity> call(String conversationId) {
    return _repository.watchConversationHeader(conversationId);
  }
}
