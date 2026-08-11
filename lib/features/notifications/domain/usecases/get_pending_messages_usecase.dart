import 'package:injectable/injectable.dart';
import '../entities/pending_message_entity.dart';
import '../repositories/pending_messages_repository.dart';

@injectable
class GetPendingMessagesUseCase {
  const GetPendingMessagesUseCase(this._repository);

  final PendingMessagesRepository _repository;

  Future<List<PendingMessageEntity>> call(String conversationId) {
    return _repository.getAll(conversationId);
  }
}
