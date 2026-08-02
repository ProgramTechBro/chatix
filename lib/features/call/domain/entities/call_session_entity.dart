import '../../../../core/enums/call_status.dart';
import '../../../../core/enums/call_type.dart';

class CallSessionEntity {
  const CallSessionEntity({
    required this.id,
    required this.conversationId,
    required this.callerId,
    required this.calleeId,
    required this.type,
    required this.status,
    required this.startedAt,
    this.endedAt,
  });

  final String id;
  final String conversationId;
  final String callerId;
  final String calleeId;
  final CallType type;
  final CallStatus status;
  final DateTime startedAt;
  final DateTime? endedAt;
}
