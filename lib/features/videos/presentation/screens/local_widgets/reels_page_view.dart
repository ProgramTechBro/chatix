import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../domain/entities/video_entity.dart';
import 'reel_video_item.dart';

class ReelsPageView extends StatefulWidget {
  const ReelsPageView({super.key, required this.videos, this.initialIndex = 0});

  final List<VideoEntity> videos;
  final int initialIndex;

  @override
  State<ReelsPageView> createState() => _ReelsPageViewState();
}

class _ReelsPageViewState extends State<ReelsPageView> {
  late final PageController _pageController = PageController(
    initialPage: widget.initialIndex,
  );
  late int _currentIndex = widget.initialIndex;
  final Map<int, VideoPlayerController> _controllers = {};

  @override
  void initState() {
    super.initState();
    _preloadAround(_currentIndex);
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    _pageController.dispose();
    super.dispose();
  }

  VideoPlayerController _createController(int index) {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videos[index].videoUrl),
    );
    controller.setLooping(true);
    controller.initialize().then((_) {
      if (!mounted) return;
      if (index == _currentIndex) {
        controller.play();
      }
    });
    return controller;
  }

  void _preloadAround(int index) {
    final keep = {index - 1, index, index + 1}
      ..removeWhere((i) => i < 0 || i >= widget.videos.length);
    for (final i in keep) {
      _controllers.putIfAbsent(i, () => _createController(i));
    }
    final stale = _controllers.keys
        .where((key) => !keep.contains(key))
        .toList();
    for (final key in stale) {
      _controllers.remove(key)?.dispose();
    }
  }

  void _onPageChanged(int index) {
    _controllers[_currentIndex]?.pause();
    setState(() => _currentIndex = index);
    _controllers[index]?.play();
    _preloadAround(index);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: widget.videos.length,
      onPageChanged: _onPageChanged,
      itemBuilder: (context, index) => ReelVideoItem(
        key: ValueKey(widget.videos[index].id),
        video: widget.videos[index],
        controller: _controllers[index],
      ),
    );
  }
}
