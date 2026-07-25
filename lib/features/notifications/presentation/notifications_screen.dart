import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text('Notifications', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
