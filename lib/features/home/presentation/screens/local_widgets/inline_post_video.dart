import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class InlinePostVideo extends StatefulWidget {
  const InlinePostVideo({
    super.key,
    required this.videoUrl,
    required this.thumbnailAsset,
  });

  final String videoUrl;
  final String thumbnailAsset;

  @override
  State<InlinePostVideo> createState() => _InlinePostVideoState();
}

class _InlinePostVideoState extends State<InlinePostVideo> {
  late final VideoPlayerController _controller =
      VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _controller
      ..setLooping(true)
      ..setVolume(0)
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() => _isInitialized = true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_isInitialized) return;
    final isInActiveZone = info.visibleFraction > 0.6;
    if (isInActiveZone && !_controller.value.isPlaying) {
      _controller.play();
    } else if (!isInActiveZone && _controller.value.isPlaying) {
      _controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(widget.videoUrl),
      onVisibilityChanged: _onVisibilityChanged,
      child: _isInitialized
          ? ClipRect(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            )
          : Image.asset(widget.thumbnailAsset, fit: BoxFit.cover),
    );
  }
}
