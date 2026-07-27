import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../domain/entities/chat_summary_entity.dart';

class ChatListCard extends StatelessWidget {
  const ChatListCard({super.key, required this.chat, this.onTap});

  final ChatSummaryEntity chat;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CircleAvatar(radius: 32, backgroundImage: NetworkImage(chat.avatarUrl)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.divider)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            chat.name,
                            style: textTheme.bodyMedium?.copyWith(fontSize: 17, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            chat.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Text(chat.time, style: textTheme.bodySmall),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
