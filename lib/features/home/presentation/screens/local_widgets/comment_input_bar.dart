import 'package:flutter/material.dart';
import '../../../../../config/app_colors.dart';

class CommentInputBar extends StatelessWidget {
  const CommentInputBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textSecondary),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.photo_library_outlined,
            size: 24,
            color: AppColors.textSecondary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Write a comment...',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Icon(
            Icons.emoji_emotions_outlined,
            size: 24,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}
