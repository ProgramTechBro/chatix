import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_assets.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/enums/request_status.dart';
import '../../../../core/shared_widgets/app_background_blobs.dart';
import '../../../../core/shared_widgets/app_button.dart';
import '../../../../core/shared_widgets/app_text_field.dart';
import '../../../../core/shared_widgets/app_top_bar.dart';
import '../../../../core/utils/helpers/validators.dart';
import '../../../../routes/app_routes.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(authNotifierProvider.notifier)
        .signInWithEmail(
          _emailController.text.trim(),
          _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    ref.listen(authNotifierProvider, (previous, next) {
      if (!(ModalRoute.of(context)?.isCurrent ?? true)) return;
      if (next.status == RequestStatus.loading) {
        BotToast.showLoading();
        return;
      }
      BotToast.closeAllLoading();
      if (next.status == RequestStatus.success && next.user != null) {
        context.go(AppRoutes.home);
      } else if (next.status == RequestStatus.failure &&
          next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const AppBackgroundBlobs(),
          SafeArea(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: AppTopBar(title: 'Login'),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      child: Column(
                        children: [
                          Image.asset(
                            AppImages.appLogo,
                            width: 140,
                            height: 140,
                          ),
                          const SizedBox(height: 16),
                          Text('Welcome back', style: textTheme.titleMedium),
                          const SizedBox(height: 6),
                          Text(
                            'Log in to keep the conversation going',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 32),
                          AppTextField(
                            label: 'Email',
                            hint: 'Enter your email',
                            prefixIcon: Icons.alternate_email_rounded,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            validator: emailValidator,
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            label: 'Password',
                            hint: 'Enter your password',
                            prefixIcon: Icons.lock_outline_rounded,
                            isPassword: true,
                            controller: _passwordController,
                            validator: passwordValidator,
                          ),
                          const SizedBox(height: 20),
                          GestureDetector(
                            onTap: () =>
                                context.push(AppRoutes.phoneVerification),
                            child: Text(
                              'Continue with phone number instead',
                              style: textTheme.bodyMedium?.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: textTheme.bodyMedium,
                              ),
                              GestureDetector(
                                onTap: () => context.push(AppRoutes.register),
                                child: Text(
                                  'Register',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: AppButton(label: 'Login', onPressed: _login),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
