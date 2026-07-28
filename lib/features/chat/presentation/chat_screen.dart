import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../config/app_colors.dart';
import '../../../core/di/injector.dart';
import '../../../routes/app_routes.dart';
import '../../chat_list/domain/entities/chat_summary_entity.dart';
import '../domain/usecases/send_message_usecase.dart';
import 'local_widgets/chat_app_bar.dart';
import 'local_widgets/chat_input_bar.dart';
import 'local_widgets/message_bubble.dart';
import 'providers/chat_provider.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key, required this.chat});

  final ChatSummaryEntity chat;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messagesAsync = ref.watch(chatMessagesProvider(chat.id));
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ChatAppBar(
                name: chat.name,
                avatarUrl: chat.avatarUrl,
                onAvatarTap: () => context.push(AppRoutes.profilePath(chat.userId)),
                onCallTap: () {},
                onVideoCallTap: () {},
              ),
            ),
            const Divider(color: AppColors.divider, height: 1, thickness: 1),
            Expanded(
              child: messagesAsync.when(
                data: (messages) => ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[messages.length - 1 - index];
                    return MessageBubble(
                      message: message,
                      avatarUrl: message.isMine ? null : chat.avatarUrl,
                    );
                  },
                ),
                loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
                error: (error, stackTrace) => Center(
                  child: Text('Something went wrong', style: textTheme.bodyMedium),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: ChatInputBar(
                onSend: (text) => getIt<SendMessageUseCase>().call(chat.id, text),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
