import 'package:injectable/injectable.dart';
import '../repositories/typing_repository.dart';

@injectable
class WatchTypingIndicatorUseCase {
  const WatchTypingIndicatorUseCase(this._repository);

  final TypingRepository _repository;

  Stream<void> call(String conversationId) {
    return _repository.watchTyping(conversationId);
  }
}
