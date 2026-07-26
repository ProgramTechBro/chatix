import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/utils/helpers/formatters.dart';
import '../../domain/entities/post_entity.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    this.onLikeTap,
    this.onCommentTap,
    this.onSendTap,
    this.onShareTap,
    this.onMoreTap,
  });

  final PostEntity post;
  final VoidCallback? onLikeTap;
  final VoidCallback? onCommentTap;
  final VoidCallback? onSendTap;
  final VoidCallback? onShareTap;
  final ValueChanged<Offset>? onMoreTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 16, backgroundImage: NetworkImage(post.authorAvatarUrl)),
                      const SizedBox(width: 8),
                      Text(post.authorName, style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                      if (post.isVerified) ...[
                        const SizedBox(width: 4),
                        SvgPicture.asset(AppIcons.postVerifiedBadge, width: 16, height: 16),
                      ],
                      const SizedBox(width: 4),
                      Text('· ${post.postedAgo}', style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary)),
                      const Spacer(),
                      GestureDetector(
                        onTapDown: (details) => onMoreTap?.call(details.globalPosition),
                        child: SvgPicture.asset(AppIcons.postMore, width: 24, height: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      style: textTheme.bodyMedium,
                      children: [
                        TextSpan(text: post.caption),
                        TextSpan(
                          text: ' see more',
                          style: textTheme.bodyMedium?.copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 353 / 296,
              child: Image.asset(post.imageAsset, fit: BoxFit.cover, width: double.infinity),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _PostAction(
                    icon: AppIcons.postLike,
                    label: formatCompactCount(post.likeCount),
                    color: post.isLiked ? AppColors.primary : AppColors.textSecondary,
                    onTap: onLikeTap,
                  ),
                  _PostAction(
                    icon: AppIcons.postComment,
                    label: formatCompactCount(post.commentCount),
                    color: AppColors.textSecondary,
                    onTap: onCommentTap,
                  ),
                  _PostAction(
                    icon: AppIcons.postSend,
                    label: 'Send',
                    color: AppColors.textSecondary,
                    onTap: onSendTap,
                  ),
                  _PostAction(
                    icon: AppIcons.postShare,
                    label: formatCompactCount(post.shareCount),
                    color: AppColors.textSecondary,
                    onTap: onShareTap,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  const _PostAction({required this.icon, required this.label, required this.color, this.onTap});

  final String icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, width: 24, height: 24, colorFilter: ColorFilter.mode(color, BlendMode.srcIn)),
          const SizedBox(width: 4),
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color)),
        ],
      ),
    );
  }
}
