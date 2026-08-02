import 'package:intl/intl.dart';
import '../../../../core/extensions/datetime_extension.dart';
import '../../domain/entities/message_entity.dart';

sealed class ChatListItem {}

class DateHeaderItem extends ChatListItem {
  DateHeaderItem(this.date);

  final DateTime date;

  String get label {
    if (date.isToday) return 'Today';
    if (date.isYesterday) return 'Yesterday';
    return DateFormat('MMMM d, yyyy').format(date);
  }
}

class MessageItem extends ChatListItem {
  MessageItem(this.message);

  final MessageEntity message;
}

List<ChatListItem> groupMessagesByDate(List<MessageEntity> messages) {
  final items = <ChatListItem>[];
  DateTime? lastDay;

  for (final message in messages) {
    final day = message.createdAt;
    if (lastDay == null || !day.isSameDay(lastDay)) {
      items.add(DateHeaderItem(day));
      lastDay = day;
    }
    items.add(MessageItem(message));
  }

  return items;
}
