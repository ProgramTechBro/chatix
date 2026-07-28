import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/message_entity.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message, this.avatarUrl});

  final MessageEntity message;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bubbleColor = message.isMine ? AppColors.primary : AppColors.surface;
    final textStyle = message.isMine
        ? textTheme.labelMedium
        : textTheme.labelMedium?.copyWith(color: AppColors.black);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: message.isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!message.isMine) ...[
            CircleAvatar(radius: 16, backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(color: bubbleColor, borderRadius: BorderRadius.circular(20)),
              child: Text(message.text, style: textStyle),
            ),
          ),
        ],
      ),
    );
  }
}
