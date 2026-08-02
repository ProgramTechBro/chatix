import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../routes/app_routes.dart';
import '../../../../videos/domain/entities/video_entity.dart';

class ProfileVideoGrid extends StatelessWidget {
  const ProfileVideoGrid({super.key, required this.videos});

  final List<VideoEntity> videos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const crossAxisCount = 3;
          const spacing = 8.0;
          final cellWidth =
              (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
              crossAxisCount;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.only(top: 16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              childAspectRatio: cellWidth / 120,
            ),
            itemCount: videos.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => context.push(
                AppRoutes.videoPlayer,
                extra: {'videos': videos, 'initialIndex': index},
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      videos[index].thumbnailAsset,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 8,
                      bottom: 8,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.black.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          size: 24,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
