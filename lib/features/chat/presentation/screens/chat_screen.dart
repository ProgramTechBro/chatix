import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/providers/auth/auth_provider.dart';
import '../../../../core/shared_widgets/app_error_view.dart';
import '../../../../core/shared_widgets/app_loader.dart';
import '../../../../routes/app_routes.dart';
import '../../domain/usecases/mark_conversation_read_usecase.dart';
import '../../domain/usecases/send_image_message_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/send_typing_indicator_usecase.dart';
import '../../domain/usecases/send_voice_message_usecase.dart';
import '../providers/chat_provider.dart';
import '../providers/typing_indicator_provider.dart';
import 'chat_header_presentation_extension.dart';
import 'local_widgets/chat_app_bar.dart';
import 'local_widgets/chat_input_bar.dart';
import 'local_widgets/message_bubble.dart';
import 'message_date_grouping.dart';

class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.conversationId});

  final String conversationId;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    super.initState();
    getIt<MarkConversationReadUseCase>().call(widget.conversationId);
  }

  @override
  Widget build(BuildContext context) {
    final headerAsync = ref.watch(chatHeaderProvider(widget.conversationId));
    final messagesAsync = ref.watch(
      chatMessagesProvider(widget.conversationId),
    );
    final isTyping = ref.watch(typingIndicatorProvider(widget.conversationId));
    final currentUserId = ref.watch(currentUserIdProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: headerAsync.when(
                data: (header) => ChatAppBar(
                  name: header.name,
                  avatarUrl: header.avatarUrl,
                  statusLabel: isTyping ? 'Typing...' : header.presenceLabel,
                  onAvatarTap: () =>
                      context.push(AppRoutes.profilePath(header.otherUserId)),
                  onCallTap: () {},
                  onVideoCallTap: () {},
                ),
                loading: () => const SizedBox(height: 48),
                error: (error, stackTrace) => const SizedBox(height: 48),
              ),
            ),
            const Divider(color: AppColors.divider, height: 1, thickness: 1),
            Expanded(
              child: messagesAsync.when(
                data: (messages) {
                  final header = headerAsync.valueOrNull;
                  final items = groupMessagesByDate(messages);
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      final item = items[items.length - 1 - index];
                      if (item is DateHeaderItem) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: Text(
                              item.label,
                              style: textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        );
                      }
                      final message = (item as MessageItem).message;
                      final isMine = message.senderId == currentUserId;
                      return MessageBubble(
                        message: message,
                        isMine: isMine,
                        avatarUrl: isMine ? null : header?.avatarUrl,
                      );
                    },
                  );
                },
                loading: () => const AppLoader(),
                error: (error, stackTrace) => const AppErrorView(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: ChatInputBar(
                onSend: (text) => getIt<SendMessageUseCase>().call(
                  conversationId: widget.conversationId,
                  text: text,
                ),
                onSendImage: (file) => getIt<SendImageMessageUseCase>().call(
                  conversationId: widget.conversationId,
                  imageFile: file,
                ),
                onSendVoice: (file, durationMs) =>
                    getIt<SendVoiceMessageUseCase>().call(
                      conversationId: widget.conversationId,
                      audioFile: file,
                      durationMs: durationMs,
                    ),
                onTyping: () => getIt<SendTypingIndicatorUseCase>().call(
                  widget.conversationId,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
