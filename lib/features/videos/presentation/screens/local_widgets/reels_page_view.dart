import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../../../../core/providers/bottom_nav_provider.dart';
import '../../../domain/entities/video_entity.dart';
import 'reel_video_item.dart';

class ReelsPageView extends ConsumerStatefulWidget {
  const ReelsPageView({
    super.key,
    required this.videos,
    this.initialIndex = 0,
    this.pauseWhenInactive = false,
  });

  final List<VideoEntity> videos;
  final int initialIndex;
  final bool pauseWhenInactive;

  @override
  ConsumerState<ReelsPageView> createState() => _ReelsPageViewState();
}

class _ReelsPageViewState extends ConsumerState<ReelsPageView> {
  static const _videosTabIndex = 1;

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

  bool get _isTabActive =>
      !widget.pauseWhenInactive ||
      ref.read(bottomNavIndexProvider) == _videosTabIndex;

  VideoPlayerController _createController(int index) {
    final controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videos[index].videoUrl),
    );
    controller.setLooping(true);
    controller.initialize().then((_) {
      if (!mounted) return;
      if (index == _currentIndex && _isTabActive) {
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
    if (_isTabActive) _controllers[index]?.play();
    _preloadAround(index);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pauseWhenInactive) {
      ref.listen(bottomNavIndexProvider, (previous, next) {
        final controller = _controllers[_currentIndex];
        if (controller == null || !controller.value.isInitialized) return;
        if (next != _videosTabIndex) {
          controller.pause();
        } else {
          controller.play();
        }
      });
    }

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
