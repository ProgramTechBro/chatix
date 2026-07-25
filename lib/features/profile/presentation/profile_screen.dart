import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text('Profile', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
