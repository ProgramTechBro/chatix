import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _birthdateController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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

  void _register() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(authNotifierProvider.notifier)
        .signUpWithEmail(
          name: _nameController.text.trim(),
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    ref.listen(authNotifierProvider, (previous, next) {
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
                    child: AppTopBar(title: 'Register'),
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
                          Text(
                            'Create your account',
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Join Chatix and start connecting',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 32),
                          AppTextField(
                            label: 'Name',
                            hint: 'Enter your full name',
                            prefixIcon: Icons.person_outline_rounded,
                            keyboardType: TextInputType.name,
                            controller: _nameController,
                            validator: nameValidator,
                          ),
                          const SizedBox(height: 16),
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
                            hint: 'Create a password',
                            prefixIcon: Icons.lock_outline_rounded,
                            isPassword: true,
                            controller: _passwordController,
                            validator: passwordValidator,
                          ),
                          const SizedBox(height: 16),
                          AppTextField(
                            label: 'Confirm password',
                            hint: 'Re-enter your password',
                            prefixIcon: Icons.lock_outline_rounded,
                            isPassword: true,
                            controller: _confirmPasswordController,
                            validator: (value) => confirmPasswordValidator(
                              value,
                              _passwordController.text,
                            ),
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
                                'Already have an account? ',
                                style: textTheme.bodyMedium,
                              ),
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
                    child: AppButton(label: 'Register', onPressed: _register),
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
