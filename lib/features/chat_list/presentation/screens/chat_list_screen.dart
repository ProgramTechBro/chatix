import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../config/app_colors.dart';
import '../../../../core/shared_widgets/app_back_button.dart';
import '../../../../core/shared_widgets/app_error_view.dart';
import '../../../../routes/app_routes.dart';
import '../../../chat/presentation/providers/chat_provider.dart';
import '../../../chat/presentation/providers/typing_indicator_provider.dart';
import '../../domain/entities/chat_summary_entity.dart';
import '../providers/chat_list_provider.dart';
import 'local_widgets/chat_list_card.dart';

final _skeletonChats = List.generate(
  6,
  (index) => ChatSummaryEntity(
    id: 'skeleton-$index',
    userId: 'skeleton-$index',
    name: 'Loading name',
    avatarUrl: '',
    lastMessage: 'Loading last message preview',
    lastMessageAt: DateTime.now(),
    isOnline: false,
    unreadCount: 0,
  ),
);

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatsAsync = ref.watch(chatListProvider);
    final readyAsync = ref.watch(chatListReadyProvider);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 20, 16),
              child: Row(
                children: [
                  const AppBackButton(),
                  Expanded(child: Text('Chats', style: textTheme.titleLarge)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _searchController,
                onChanged: (value) =>
                    setState(() => _query = value.toLowerCase()),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: chatsAsync.when(
                data: (chats) {
                  if (!readyAsync.hasValue) {
                    return Skeletonizer(
                      child: ListView.builder(
                        itemCount: _skeletonChats.length,
                        itemBuilder: (context, index) =>
                            ChatListCard(chat: _skeletonChats[index]),
                      ),
                    );
                  }
                  final filtered = chats
                      .where((chat) => chat.name.toLowerCase().contains(_query))
                      .toList();
                  if (filtered.isEmpty) {
                    return Center(
                      child: Text(
                        'No chats yet',
                        style: textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final chat = filtered[index];
                      return Consumer(
                        builder: (context, ref, _) {
                          final isTyping = ref.watch(
                            typingIndicatorProvider(chat.id),
                          );
                          return ChatListCard(
                            chat: chat,
                            isTyping: isTyping,
                            onAvatarTap: () => context.push(
                              AppRoutes.profilePath(chat.userId),
                            ),
                            onTap: () {
                              ref.read(chatMessagesProvider(chat.id).future);
                              ref.read(chatHeaderProvider(chat.id).future);
                              context.push(AppRoutes.chatDetailPath(chat.id));
                            },
                          );
                        },
                      );
                    },
                  );
                },
                loading: () => Skeletonizer(
                  child: ListView.builder(
                    itemCount: _skeletonChats.length,
                    itemBuilder: (context, index) =>
                        ChatListCard(chat: _skeletonChats[index]),
                  ),
                ),
                // error: (error, stackTrace) => const AppErrorView(),
                error: (error, stackTrace) {
                  debugPrint('Chat list error: $error');
                  debugPrint('Chat list stack trace: $stackTrace');
                  return const AppErrorView();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
