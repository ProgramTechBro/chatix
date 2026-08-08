import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/enums/request_status.dart';
import '../../../../core/shared_widgets/app_background_blobs.dart';
import '../../../../core/shared_widgets/app_top_bar.dart';
import '../../../../routes/app_routes.dart';
import '../providers/auth_provider.dart';
import 'local_widgets/otp_input_field.dart';

class OtpScreen extends ConsumerWidget {
  const OtpScreen({super.key, required this.phoneNumber, required this.name});

  final String phoneNumber;
  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: AppTopBar(title: 'Enter code'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Column(
                    children: [
                      Text('Verification code', style: textTheme.titleMedium),
                      const SizedBox(height: 6),
                      Text(
                        'Enter the 6-digit code sent to $phoneNumber',
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      OtpInputField(
                        onCompleted: (code) => ref
                            .read(authNotifierProvider.notifier)
                            .confirmPhoneOtp(
                              smsCode: code,
                              phoneNumber: phoneNumber,
                              name: name,
                            ),
                      ),
                    ],
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
