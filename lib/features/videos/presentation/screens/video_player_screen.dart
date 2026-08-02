import 'package:flutter/material.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/shared_widgets/app_back_button.dart';
import '../../domain/entities/video_entity.dart';
import 'local_widgets/reels_page_view.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({
    super.key,
    required this.videos,
    required this.initialIndex,
  });

  final List<VideoEntity> videos;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          ReelsPageView(videos: videos, initialIndex: initialIndex),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 8,
            child: const AppBackButton(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
