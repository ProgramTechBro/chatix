import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_background_blobs.dart';
import '../../../core/shared_widgets/app_button.dart';
import '../../../core/shared_widgets/app_text_field.dart';
import '../../../core/shared_widgets/app_top_bar.dart';
import '../../../routes/app_routes.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _birthdateController = TextEditingController();

  @override
  void dispose() {
    _birthdateController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthdate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(now.year - 100),
      lastDate: now,
    );
    if (picked != null) {
      _birthdateController.text = DateFormat('d MMM yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          const AppBackgroundBlobs(),
          SafeArea(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: AppTopBar(title: 'Register'),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: Column(
                      children: [
                        Image.asset(AppImages.appLogo, width: 140, height: 140),
                        const SizedBox(height: 16),
                        Text('Create your account', style: textTheme.titleMedium),
                        const SizedBox(height: 6),
                        Text(
                          'Join Chatix and start connecting',
                          textAlign: TextAlign.center,
                          style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                        ),
                        const SizedBox(height: 32),
                        const AppTextField(
                          label: 'Name',
                          hint: 'Enter your full name',
                          prefixIcon: Icons.person_outline_rounded,
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 16),
                        const AppTextField(
                          label: 'Phone or email',
                          hint: 'Enter your phone or email',
                          prefixIcon: Icons.alternate_email_rounded,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),
                        const AppTextField(
                          label: 'Password',
                          hint: 'Create a password',
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: true,
                        ),
                        const SizedBox(height: 16),
                        const AppTextField(
                          label: 'Confirm password',
                          hint: 'Re-enter your password',
                          prefixIcon: Icons.lock_outline_rounded,
                          isPassword: true,
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          label: 'Birthdate',
                          hint: 'Enter your birth date',
                          prefixIcon: Icons.cake_outlined,
                          readOnly: true,
                          controller: _birthdateController,
                          onTap: _pickBirthdate,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Already have an account? ', style: textTheme.bodyMedium),
                            GestureDetector(
                              onTap: () {
                                if (context.canPop()) {
                                  context.pop();
                                } else {
                                  context.go(AppRoutes.login);
                                }
                              },
                              child: Text(
                                'Login',
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
                  child: AppButton(
                    label: 'Register',
                    onPressed: () => context.go(AppRoutes.home),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
