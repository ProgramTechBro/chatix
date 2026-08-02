import '../../domain/entities/call_session_entity.dart';

class CallSessionModel extends CallSessionEntity {
  const CallSessionModel({
    required super.id,
    required super.conversationId,
    required super.callerId,
    required super.calleeId,
    required super.type,
    required super.status,
    required super.startedAt,
    super.endedAt,
  });
}
