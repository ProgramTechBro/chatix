import 'package:flutter/material.dart';
import '../../config/app_colors.dart';

class AppBackgroundBlobs extends StatelessWidget {
  const AppBackgroundBlobs({super.key});

  @override
  Widget build(BuildContext context) {
    return const IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -90,
            right: -90,
            child: _Blob(size: 220, opacity: 0.22),
          ),
          Positioned(
            bottom: -110,
            left: -110,
            child: _Blob(size: 260, opacity: 0.18),
          ),
          Positioned(
            top: 140,
            left: -50,
            child: _Blob(size: 100, opacity: 0.16),
          ),
          Positioned(
            bottom: 160,
            right: -30,
            child: _Blob(size: 80, opacity: 0.16),
          ),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: opacity),
            AppColors.primary.withValues(alpha: 0.0),
          ],
          stops: const [0.0, 1.0],
        ),
      ),
    );
  }
}
