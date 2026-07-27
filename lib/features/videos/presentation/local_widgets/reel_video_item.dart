import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';
import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/utils/helpers/formatters.dart';
import '../../domain/entities/video_entity.dart';

class ReelVideoItem extends StatefulWidget {
  const ReelVideoItem({super.key, required this.video, required this.isActive});

  final VideoEntity video;
  final bool isActive;

  @override
  State<ReelVideoItem> createState() => _ReelVideoItemState();
}

class _ReelVideoItemState extends State<ReelVideoItem> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl));
    _controller = controller;
    await controller.initialize();
    await controller.setLooping(true);
    if (!mounted) return;
    setState(() => _isInitialized = true);
    if (widget.isActive) {
      controller.play();
    }
  }

  @override
  void didUpdateWidget(covariant ReelVideoItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    final controller = _controller;
    if (controller == null || !_isInitialized) return;
    if (widget.isActive && !oldWidget.isActive) {
      controller.play();
    } else if (!widget.isActive && oldWidget.isActive) {
      controller.pause();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    final controller = _controller;
    if (controller == null) return;
    setState(() {
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (_isInitialized && controller != null)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: controller.value.size.width,
                height: controller.value.size.height,
                child: VideoPlayer(controller),
              ),
            )
          else
            Image.asset(widget.video.thumbnailAsset, fit: BoxFit.cover),
          if (_isInitialized && controller != null && !controller.value.isPlaying)
            Center(
              child: Icon(Icons.play_arrow_rounded, size: 72, color: AppColors.white.withValues(alpha: 0.7)),
            ),
          Positioned(
            left: 20,
            right: 90,
            bottom: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.video.authorName,
                  style: textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Text(widget.video.caption, style: textTheme.bodyMedium?.copyWith(color: AppColors.white)),
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
                Text(
                  formatCompactCount(widget.video.likeCount),
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
