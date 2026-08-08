import '../../domain/entities/chat_summary_entity.dart';

extension ChatSummaryPresentation on ChatSummaryEntity {
  bool get isActuallyOnline {
    return isOnline &&
        lastSeenAt != null &&
        lastSeenAt!.isAfter(
          DateTime.now().subtract(const Duration(minutes: 2)),
        );
  }
}
