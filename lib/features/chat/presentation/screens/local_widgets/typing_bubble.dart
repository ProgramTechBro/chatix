import 'package:flutter/material.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../core/shared_widgets/app_avatar.dart';

class TypingBubble extends StatelessWidget {
  const TypingBubble({super.key, this.avatarUrl});

  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          avatarUrl != null
              ? AppAvatar(imageUrl: avatarUrl!, radius: 16)
              : const CircleAvatar(radius: 16),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Typing...',
              style: Theme.of(
                context,
              ).textTheme.labelMedium?.copyWith(color: AppColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
