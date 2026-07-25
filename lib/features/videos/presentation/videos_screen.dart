import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class VideosScreen extends StatelessWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text('Videos', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
