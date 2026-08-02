import 'dart:async';
import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/chat_header_model.dart';
import '../../models/message_model.dart';
import 'chat_remote_datasource.dart';

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl(this._client);

  final SupabaseClient _client;

  String get _currentUserId => _client.auth.currentUser!.id;

  Future<List<MessageModel>> _fetchMessages(String conversationId) async {
    final rows = await _client
        .from('messages')
        .select()
        .eq('conversation_id', conversationId)
        .order('created_at');
    return rows.map(MessageModel.fromJson).toList();
  }

  @override
  Stream<List<MessageModel>> watchMessages(String conversationId) async* {
    yield await _fetchMessages(conversationId);

    final controller = StreamController<List<MessageModel>>();
    final channel = _client
        .channel('messages:$conversationId')
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
        .subscribe();

    try {
      yield* controller.stream;
    } finally {
      await _client.removeChannel(channel);
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

  @override
  Future<ChatHeaderModel> getConversationHeader(String conversationId) async {
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
          ? DateTime.parse(profile['last_seen_at'] as String)
          : null,
    );
  }

  @override
  Future<void> markConversationRead(String conversationId) async {
    await _client.rpc(
      'mark_conversation_read',
      params: {'p_conversation_id': conversationId},
    );
  }
}
