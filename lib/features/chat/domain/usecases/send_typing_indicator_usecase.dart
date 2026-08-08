import 'package:injectable/injectable.dart';
import '../repositories/typing_repository.dart';

@injectable
class SendTypingIndicatorUseCase {
  const SendTypingIndicatorUseCase(this._repository);

  final TypingRepository _repository;

  Future<void> call(String conversationId) {
    return _repository.sendTyping(conversationId);
  }
}
