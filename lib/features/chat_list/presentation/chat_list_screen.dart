import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Text('Home', style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
