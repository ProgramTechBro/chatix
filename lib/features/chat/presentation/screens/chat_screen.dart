import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/message_status.dart';
import '../../../../core/enums/message_type.dart';
import '../../../../core/providers/auth/auth_provider.dart';
import '../../../../core/services/active_conversation_tracker.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../core/services/push_notification_service.dart';
import '../../../../core/shared_widgets/app_error_view.dart';
import '../../../../routes/app_routes.dart';
import '../../../notifications/domain/usecases/clear_pending_messages_usecase.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/mark_conversation_read_usecase.dart';
import '../../domain/usecases/send_image_message_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/send_typing_indicator_usecase.dart';
import '../../domain/usecases/send_voice_message_usecase.dart';
import '../providers/chat_provider.dart';
import '../providers/typing_indicator_provider.dart';
import '../providers/voice_message_provider.dart';
import 'chat_header_presentation_extension.dart';
import 'local_widgets/chat_app_bar.dart';
import 'local_widgets/chat_input_bar.dart';
import 'local_widgets/message_bubble.dart';
import 'local_widgets/typing_bubble.dart';
import 'message_date_grouping.dart';

final _skeletonMessages = List.generate(
  8,
  (index) => MessageEntity(
    id: 'skeleton-$index',
    conversationId: 'skeleton',
    senderId: index.isEven ? 'skeleton-me' : 'skeleton-them',
    type: MessageType.text,
    text: 'Loading message preview',
    status: MessageStatus.sent,
    createdAt: DateTime.now(),
  ),
);

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
    getIt<ActiveConversationTracker>().current = widget.conversationId;
    _markAsRead();
  }

  @override
  void dispose() {
    if (getIt<ActiveConversationTracker>().current == widget.conversationId) {
      getIt<ActiveConversationTracker>().current = null;
    }
    super.dispose();
  }

  Future<void> _markAsRead() async {
    final result = await getIt<MarkConversationReadUseCase>().call(
      widget.conversationId,
    );
    result.fold(
      (failure) => getIt<LoggerService>().logError(Exception(failure.message)),
      (_) {},
    );
    await getIt<ClearPendingMessagesUseCase>().call(widget.conversationId);
    await getIt<PushNotificationService>().clearNotification(
      widget.conversationId,
    );
  }

  void _prefetchVoiceWaveforms(List<MessageEntity> messages) {
    for (final message in messages) {
      final mediaUrl = message.mediaUrl;
      if (message.type == MessageType.voice && mediaUrl != null) {
        ref.read(voiceMessageProvider(mediaUrl).future);
      }
    }
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

    ref.listen(chatMessagesProvider(widget.conversationId), (previous, next) {
      final prevMessages = previous?.valueOrNull;
      final currMessages = next.valueOrNull;
      if (currMessages == null || currMessages.isEmpty) return;
      if (prevMessages != null && prevMessages.length == currMessages.length) {
        return;
      }
      if (currMessages.last.senderId != currentUserId) _markAsRead();
    });

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
                  _prefetchVoiceWaveforms(messages);
                  final header = headerAsync.valueOrNull;
                  final items = groupMessagesByDate(messages);
                  final itemCount = items.length + (isTyping ? 1 : 0);
                  return ListView.builder(
                    reverse: true,
                    scrollCacheExtent: const ScrollCacheExtent.pixels(800),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    itemCount: itemCount,
                    itemBuilder: (context, index) {
                      if (isTyping && index == 0) {
                        return TypingBubble(avatarUrl: header?.avatarUrl);
                      }
                      final itemIndex = isTyping ? index - 1 : index;
                      final item = items[items.length - 1 - itemIndex];
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
                        key: ValueKey(message.id),
                        message: message,
                        isMine: isMine,
                        avatarUrl: isMine ? null : header?.avatarUrl,
                      );
                    },
                  );
                },
                loading: () => Skeletonizer(
                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    itemCount: _skeletonMessages.length,
                    itemBuilder: (context, index) => MessageBubble(
                      message: _skeletonMessages[index],
                      isMine: index.isEven,
                    ),
                  ),
                ),
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
