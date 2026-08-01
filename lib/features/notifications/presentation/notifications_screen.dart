import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../config/app_colors.dart';
import '../../../core/shared_widgets/app_back_button.dart';
import 'local_widgets/notification_card.dart';
import 'providers/notifications_provider.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsAsync = ref.watch(notificationsProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 56,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text('Notifications', style: textTheme.titleSmall),
                  const Align(alignment: Alignment.centerLeft, child: AppBackButton()),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: notificationsAsync.when(
                data: (notifications) => ListView.builder(
                  itemCount: notifications.length,
                  itemBuilder: (context, index) => NotificationCard(notification: notifications[index]),
                ),
                loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                error: (error, stackTrace) => Center(
                  child: Text('Something went wrong', style: textTheme.bodyMedium),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
