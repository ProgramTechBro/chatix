import 'package:injectable/injectable.dart';
import '../repositories/pending_messages_repository.dart';

@injectable
class ClearPendingMessagesUseCase {
  const ClearPendingMessagesUseCase(this._repository);

  final PendingMessagesRepository _repository;

  Future<void> call(String conversationId) {
    return _repository.clear(conversationId);
  }
}
