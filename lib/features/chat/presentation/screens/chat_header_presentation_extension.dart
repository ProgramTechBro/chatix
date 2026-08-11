import 'package:intl/intl.dart';
import '../../../../core/extensions/datetime_extension.dart';
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
    final seen = lastSeenAt;
    if (seen == null) return 'Offline';
    final time = DateFormat('h:mm a').format(seen);
    if (seen.isToday) return 'Last seen today at $time';
    if (seen.isYesterday) return 'Last seen yesterday at $time';
    return 'Last seen ${DateFormat('MMM d').format(seen)} at $time';
  }
}
