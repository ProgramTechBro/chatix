import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/shared_widgets/app_back_button.dart';
import '../../../../core/shared_widgets/app_button.dart';
import '../../../../routes/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const Expanded(flex: 4, child: _WelcomeHero()),
          Expanded(
            flex: 3,
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome to\nChatix', style: textTheme.titleLarge),
                    const SizedBox(height: 24),
                    Text(
                      'Step into Chatix — a space designed to bring people closer, '
                      'spark conversations, and celebrate moments that matter. Connect, '
                      'share, and discover a world of possibilities at your fingertips.',
                      style: textTheme.bodyMedium,
                    ),
                    const Spacer(),
                    AppButton(
                      label: 'Get started',
                      onPressed: () => context.push(AppRoutes.login),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeHero extends StatelessWidget {
  const _WelcomeHero();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(AppImages.welcomeHero, fit: BoxFit.cover),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.transparent, AppColors.white],
              stops: [0.0, 0.75, 1.0],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).padding.top,
          left: 8,
          child: const AppBackButton(),
        ),
      ],
    );
  }
}
