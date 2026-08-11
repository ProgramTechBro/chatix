import 'dart:async';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/services/logger_service.dart';
import '../../models/chat_header_model.dart';
import '../../models/message_model.dart';
import 'chat_remote_datasource.dart';

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl(this._client, this._logger);

  final SupabaseClient _client;
  final LoggerService _logger;

  String get _currentUserId => _client.auth.currentUser!.id;

  Future<List<MessageModel>> _fetchMessages(String conversationId) async {
    final rows = await _client
        .from('messages')
        .select()
        .eq('conversation_id', conversationId)
        .order('created_at', ascending: true);
    return rows.map(MessageModel.fromJson).toList();
  }

  @override
  Stream<List<MessageModel>> watchMessages(String conversationId) async* {
    final controller = StreamController<List<MessageModel>>();
    RealtimeChannel? channel;
    Timer? retryTimer;
    var isActive = true;

    void subscribeChannel() {
      channel = _client
          .channel(
            'messages:$conversationId',
            opts: const RealtimeChannelConfig(private: true),
          )
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'messages',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'conversation_id',
              value: conversationId,
            ),
            callback: (payload) async {
              controller.add(await _fetchMessages(conversationId));
            },
          )
          .subscribe((status, error) {
            _logger.logInfo(
              'messages:$conversationId subscribe status: $status',
            );
            if (error != null) _logger.logError(error);
            if (status == RealtimeSubscribeStatus.subscribed) {
              _fetchMessages(conversationId).then((messages) {
                if (isActive) controller.add(messages);
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
    yield await _fetchMessages(conversationId);
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
  Future<void> sendMessage({
    required String conversationId,
    required String type,
    String? text,
    String? mediaUrl,
    int? mediaDurationMs,
  }) async {
    await _client.from('messages').insert({
      'conversation_id': conversationId,
      'sender_id': _currentUserId,
      'type': type,
      'text': text,
      'media_url': mediaUrl,
      'media_duration_ms': mediaDurationMs,
    });
  }

  @override
  Future<String> uploadChatMedia(String conversationId, File file) async {
    final fileName =
        '$conversationId/${DateTime.now().microsecondsSinceEpoch}${file.path.substring(file.path.lastIndexOf('.'))}';
    await _client.storage.from('chat-media').upload(fileName, file);
    return _client.storage.from('chat-media').getPublicUrl(fileName);
  }

  Future<ChatHeaderModel> _fetchHeader(String conversationId) async {
    final row = await _client
        .from('conversation_participants')
        .select(
          'user_id, profiles!inner(name, avatar_url, is_online, last_seen_at)',
        )
        .eq('conversation_id', conversationId)
        .neq('user_id', _currentUserId)
        .single();

    final profile = row['profiles'] as Map<String, dynamic>;
    return ChatHeaderModel(
      conversationId: conversationId,
      otherUserId: row['user_id'] as String,
      name: profile['name'] as String,
      avatarUrl: profile['avatar_url'] as String? ?? '',
      isOnline: profile['is_online'] as bool? ?? false,
      lastSeenAt: profile['last_seen_at'] != null
          ? DateTime.parse(profile['last_seen_at'] as String).toLocal()
          : null,
    );
  }

  @override
  Stream<ChatHeaderModel> watchConversationHeader(
    String conversationId,
  ) async* {
    final initialHeader = await _fetchHeader(conversationId);
    yield initialHeader;

    final controller = StreamController<ChatHeaderModel>();
    RealtimeChannel? channel;
    Timer? retryTimer;
    var isActive = true;

    void subscribeChannel() {
      channel = _client
          .channel(
            'profile:${initialHeader.otherUserId}',
            opts: const RealtimeChannelConfig(private: true),
          )
          .onPostgresChanges(
            event: PostgresChangeEvent.update,
            schema: 'public',
            table: 'profiles',
            filter: PostgresChangeFilter(
              type: PostgresChangeFilterType.eq,
              column: 'id',
              value: initialHeader.otherUserId,
            ),
            callback: (payload) async {
              controller.add(await _fetchHeader(conversationId));
            },
          )
          .subscribe((status, error) {
            _logger.logInfo(
              'profile:${initialHeader.otherUserId} subscribe status: $status',
            );
            if (error != null) _logger.logError(error);
            if (status == RealtimeSubscribeStatus.subscribed) {
              _fetchHeader(conversationId).then((header) {
                if (isActive) controller.add(header);
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
  Future<void> markConversationRead(String conversationId) async {
    await _client.rpc(
      'mark_conversation_read',
      params: {'p_conversation_id': conversationId},
    );
  }
}
