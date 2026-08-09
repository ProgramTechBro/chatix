import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/enums/request_status.dart';
import '../../../../core/shared_widgets/app_background_blobs.dart';
import '../../../../core/shared_widgets/app_button.dart';
import '../../../../core/shared_widgets/app_text_field.dart';
import '../../../../core/shared_widgets/app_top_bar.dart';
import '../../../../core/utils/helpers/validators.dart';
import '../../../../routes/app_routes.dart';
import '../providers/auth_provider.dart';

class EnterNameScreen extends ConsumerStatefulWidget {
  const EnterNameScreen({super.key});

  @override
  ConsumerState<EnterNameScreen> createState() => _EnterNameScreenState();
}

class _EnterNameScreenState extends ConsumerState<EnterNameScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _continue() {
    if (!_formKey.currentState!.validate()) return;
    ref
        .read(authNotifierProvider.notifier)
        .updateDisplayName(_nameController.text.trim());
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
      if (next.status == RequestStatus.success) {
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
                    child: AppTopBar(title: 'Almost there'),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      child: Column(
                        children: [
                          Text(
                            'What should we call you?',
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'This is how you will appear to others on Chatix',
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
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    child: AppButton(label: 'Continue', onPressed: _continue),
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
