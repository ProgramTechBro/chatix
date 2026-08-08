abstract class TypingRepository {
  Future<void> sendTyping(String conversationId);

  Stream<void> watchTyping(String conversationId);
}
