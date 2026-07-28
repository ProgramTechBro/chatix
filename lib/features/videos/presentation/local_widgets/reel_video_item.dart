import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/utils/helpers/formatters.dart';
import '../../domain/entities/video_entity.dart';

class ReelVideoItem extends StatelessWidget {
  const ReelVideoItem({super.key, required this.video, required this.controller});

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
            bottom: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(video.authorName, style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Text(video.caption, style: textTheme.bodyMedium?.copyWith(color: AppColors.white)),
              ],
            ),
          ),
          Positioned(
            right: 20,
            bottom: 40,
            child: Column(
              children: [
                SvgPicture.asset(
                  AppIcons.postLike,
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
                const SizedBox(height: 4),
                Text(formatCompactCount(video.likeCount), style: textTheme.bodyMedium?.copyWith(color: AppColors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
