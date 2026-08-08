abstract class TypingRemoteDataSource {
  Future<void> sendTyping(String conversationId);

  Stream<void> watchTyping(String conversationId);
}
