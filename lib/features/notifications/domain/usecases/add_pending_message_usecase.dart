import 'package:injectable/injectable.dart';
import '../entities/pending_message_entity.dart';
import '../repositories/pending_messages_repository.dart';

@injectable
class AddPendingMessageUseCase {
  const AddPendingMessageUseCase(this._repository);

  final PendingMessagesRepository _repository;

  Future<void> call(String conversationId, PendingMessageEntity message) {
    return _repository.add(conversationId, message);
  }
}
