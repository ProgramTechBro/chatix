import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/utils/helpers/formatters.dart';
import '../../domain/entities/comment_entity.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({super.key, required this.comment});

  final CommentEntity comment;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 16, backgroundImage: NetworkImage(comment.authorAvatarUrl)),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(comment.authorName, style: textTheme.headlineSmall),
                    const SizedBox(width: 4),
                    Text(
                      '· ${comment.postedAgo}',
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(100)),
                  child: Text(comment.message, style: textTheme.bodySmall?.copyWith(color: AppColors.black)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.favorite_border, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text(formatCompactCount(comment.likeCount), style: textTheme.bodySmall?.copyWith(fontSize: 10)),
                    const SizedBox(width: 16),
                    Text('Reply', style: textTheme.bodySmall?.copyWith(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
