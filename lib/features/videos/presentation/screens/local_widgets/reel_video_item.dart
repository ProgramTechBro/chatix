import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import '../../../../../config/app_assets.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../core/utils/helpers/formatters.dart';
import '../../../domain/entities/video_entity.dart';

class ReelVideoItem extends StatelessWidget {
  const ReelVideoItem({
    super.key,
    required this.video,
    required this.controller,
  });

  final VideoEntity video;
  final VideoPlayerController? controller;

  void _togglePlayPause() {
    final controller = this.controller;
    if (controller == null || !controller.value.isInitialized) return;
    controller.value.isPlaying ? controller.pause() : controller.play();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (controller != null)
            AnimatedBuilder(
              animation: controller!,
              builder: (context, _) {
                if (!controller!.value.isInitialized) {
                  return Image.asset(video.thumbnailAsset, fit: BoxFit.cover);
                }
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: controller!.value.size.width,
                        height: controller!.value.size.height,
                        child: VideoPlayer(controller!),
                      ),
                    ),
                    if (!controller!.value.isPlaying)
                      Center(
                        child: Icon(
                          Icons.play_arrow_rounded,
                          size: 72,
                          color: AppColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                  ],
                );
              },
            )
          else
            Image.asset(video.thumbnailAsset, fit: BoxFit.cover),
          Positioned(
            left: 20,
            right: 90,
            bottom: 25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  video.authorName,
                  style: textTheme.titleSmall?.copyWith(color: AppColors.white),
                ),
                const SizedBox(height: 8),
                Text(video.caption, style: textTheme.labelMedium),
              ],
            ),
          ),
          Positioned(right: 12, bottom: 150, child: _ActionRail(video: video)),
        ],
      ),
    );
  }
}

class _ActionRail extends StatelessWidget {
  const _ActionRail({required this.video});

  final VideoEntity video;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(video.authorAvatarUrl),
              ),
              const Positioned(
                right: -2,
                bottom: -2,
                child: Icon(
                  Icons.add_circle_rounded,
                  size: 16,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _ActionItem(icon: AppIcons.postLike, count: video.likeCount),
          const SizedBox(height: 24),
          _ActionItem(icon: AppIcons.postComment, count: video.commentCount),
          const SizedBox(height: 24),
          _ActionItem(icon: AppIcons.postShare, count: video.shareCount),
          const SizedBox(height: 24),
          _SaveActionItem(count: video.saveCount),
        ],
      ),
    );
  }
}

class _ActionItem extends StatelessWidget {
  const _ActionItem({required this.icon, required this.count});

  final String icon;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          width: 24,
          height: 24,
          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        ),
        const SizedBox(height: 8),
        Text(
          formatCompactCount(count),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}

class _SaveActionItem extends StatelessWidget {
  const _SaveActionItem({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.bookmark_border_rounded,
          size: 24,
          color: AppColors.white,
        ),
        const SizedBox(height: 8),
        Text(
          formatCompactCount(count),
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
