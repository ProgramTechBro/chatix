import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/services/logger_service.dart';
import '../../models/chat_summary_model.dart';
import 'chat_list_remote_datasource.dart';

@LazySingleton(as: ChatListRemoteDataSource)
class ChatListRemoteDataSourceImpl implements ChatListRemoteDataSource {
  ChatListRemoteDataSourceImpl(this._client, this._logger);

  final SupabaseClient _client;
  final LoggerService _logger;

  String get _currentUserId => _client.auth.currentUser!.id;

  String _previewFor(Map<String, dynamic> message) {
    switch (message['type'] as String) {
      case 'image':
        return '📷 Photo';
      case 'voice':
        return '🎤 Voice message';
      default:
        return message['text'] as String? ?? '';
    }
  }

  Future<List<ChatSummaryModel>> _fetchChatList() async {
    final myRows = await _client
        .from('conversation_participants')
        .select('conversation_id, unread_count')
        .eq('user_id', _currentUserId);

    if (myRows.isEmpty) return [];

    final conversationIds = myRows
        .map((row) => row['conversation_id'] as String)
        .toList();
    final unreadByConversation = {
      for (final row in myRows)
        row['conversation_id'] as String: row['unread_count'] as int,
    };

    final otherRows = await _client
        .from('conversation_participants')
        .select(
          'conversation_id, user_id, profiles!inner(name, avatar_url, is_online, last_seen_at)',
        )
        .inFilter('conversation_id', conversationIds)
        .neq('user_id', _currentUserId);

    final conversationRows = await _client
        .from('conversations')
        .select('id, last_message_at')
        .inFilter('id', conversationIds);
    final lastMessageAtByConversation = {
      for (final row in conversationRows)
        row['id'] as String: DateTime.parse(
          row['last_message_at'] as String,
        ).toLocal(),
    };

    final previews = await Future.wait(
      conversationIds.map((id) async {
        final rows = await _client
            .from('messages')
            .select('type, text')
            .eq('conversation_id', id)
            .order('created_at', ascending: false)
            .limit(1);
        return MapEntry(id, rows.isNotEmpty ? _previewFor(rows.first) : '');
      }),
    );
    final previewByConversation = Map<String, String>.fromEntries(previews);

    final summaries = otherRows.map((row) {
      final conversationId = row['conversation_id'] as String;
      final profile = row['profiles'] as Map<String, dynamic>;
      return ChatSummaryModel(
        id: conversationId,
        userId: row['user_id'] as String,
        name: profile['name'] as String,
        avatarUrl: profile['avatar_url'] as String? ?? '',
        lastMessage: previewByConversation[conversationId] ?? '',
        lastMessageAt:
            lastMessageAtByConversation[conversationId] ?? DateTime.now(),
        isOnline: profile['is_online'] as bool? ?? false,
        unreadCount: unreadByConversation[conversationId] ?? 0,
        lastSeenAt: profile['last_seen_at'] != null
            ? DateTime.parse(profile['last_seen_at'] as String).toLocal()
            : null,
      );
    }).toList();

    summaries.sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));
    return summaries;
  }

  @override
  Stream<List<ChatSummaryModel>> watchChatList() async* {
    final controller = StreamController<List<ChatSummaryModel>>();
    RealtimeChannel? channel;
    Timer? retryTimer;
    var isActive = true;

    void subscribeChannel() {
      channel = _client
          .channel(
            'conversation_participants:$_currentUserId',
            opts: const RealtimeChannelConfig(private: true),
          )
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'conversation_participants',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'user_id',
              value: _currentUserId,
            ),
            callback: (payload) async {
              controller.add(await _fetchChatList());
            },
          )
          .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'public',
            table: 'profiles',
            callback: (payload) async {
              controller.add(await _fetchChatList());
            },
          )
          .subscribe((status, error) {
            _logger.logInfo(
              'conversation_participants:$_currentUserId subscribe status: $status',
            );
            if (error != null) _logger.logError(error);
            if (status == RealtimeSubscribeStatus.subscribed) {
              _fetchChatList().then((chats) {
                if (isActive) controller.add(chats);
              });
            } else if (isActive &&
                (status == RealtimeSubscribeStatus.channelError ||
                    status == RealtimeSubscribeStatus.timedOut)) {
              final failed = channel;
              if (failed != null) _client.removeChannel(failed);
              retryTimer?.cancel();
              retryTimer = Timer(const Duration(seconds: 3), subscribeChannel);
            }
          });
    }

    subscribeChannel();
    yield await _fetchChatList();
    try {
      yield* controller.stream;
    } finally {
      isActive = false;
      retryTimer?.cancel();
      final activeChannel = channel;
      if (activeChannel != null) await _client.removeChannel(activeChannel);
      await controller.close();
    }
  }

  @override
  Future<String> getOrCreateDirectConversation(String otherUserId) async {
    final result = await _client.rpc(
      'get_or_create_direct_conversation',
      params: {'other_user_id': otherUserId},
    );
    return result as String;
  }
}
