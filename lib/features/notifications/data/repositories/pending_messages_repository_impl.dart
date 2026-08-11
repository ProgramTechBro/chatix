import 'package:injectable/injectable.dart';
import '../../domain/entities/pending_message_entity.dart';
import '../../domain/repositories/pending_messages_repository.dart';
import '../datasources/local/pending_message_local_datasource.dart';
import '../models/pending_message_model.dart';

@LazySingleton(as: PendingMessagesRepository)
class PendingMessagesRepositoryImpl implements PendingMessagesRepository {
  const PendingMessagesRepositoryImpl(this._localDataSource);

  final PendingMessageLocalDataSource _localDataSource;

  @override
  Future<void> add(String conversationId, PendingMessageEntity message) {
    return _localDataSource.add(
      conversationId,
      PendingMessageModel(
        messageId: message.messageId,
        senderName: message.senderName,
        senderAvatarUrl: message.senderAvatarUrl,
        preview: message.preview,
        createdAt: message.createdAt,
      ),
    );
  }

  @override
  Future<List<PendingMessageEntity>> getAll(String conversationId) {
    return _localDataSource.getAll(conversationId);
  }

  @override
  Future<void> clear(String conversationId) {
    return _localDataSource.clear(conversationId);
  }
}
