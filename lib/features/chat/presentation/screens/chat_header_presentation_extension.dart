import 'package:intl/intl.dart';
import '../../domain/entities/chat_header_entity.dart';

extension ChatHeaderPresentation on ChatHeaderEntity {
  bool get isActuallyOnline {
    return isOnline &&
        lastSeenAt != null &&
        lastSeenAt!.isAfter(
          DateTime.now().subtract(const Duration(minutes: 2)),
        );
  }

  String get presenceLabel {
    if (isActuallyOnline) return 'Online';
    if (lastSeenAt == null) return 'Offline';
    return 'Last seen ${DateFormat('h:mm a').format(lastSeenAt!)}';
  }
}
