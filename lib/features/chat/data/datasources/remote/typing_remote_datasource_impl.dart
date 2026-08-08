import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'typing_remote_datasource.dart';

@LazySingleton(as: TypingRemoteDataSource)
class TypingRemoteDataSourceImpl implements TypingRemoteDataSource {
  TypingRemoteDataSourceImpl(this._client);

  final SupabaseClient _client;
  String? _conversationId;
  RealtimeChannel? _channel;
  StreamController<void>? _controller;

  String get _currentUserId => _client.auth.currentUser!.id;

  RealtimeChannel _channelFor(String conversationId) {
    if (_conversationId == conversationId && _channel != null) {
      return _channel!;
    }
    _teardown();

    final controller = StreamController<void>.broadcast(onCancel: _teardown);
    final channel = _client
        .channel('conversation:$conversationId')
        .onBroadcast(
          event: 'typing',
          callback: (payload) {
            if (payload['user_id'] != _currentUserId) controller.add(null);
          },
        )
        .subscribe();

    _conversationId = conversationId;
    _channel = channel;
    _controller = controller;
    return channel;
  }

  void _teardown() {
    final channel = _channel;
    if (channel != null) _client.removeChannel(channel);
    _controller?.close();
    _conversationId = null;
    _channel = null;
    _controller = null;
  }

  @override
  Future<void> sendTyping(String conversationId) async {
    await _channelFor(conversationId).sendBroadcastMessage(
      event: 'typing',
      payload: {'user_id': _currentUserId},
    );
  }

  @override
  Stream<void> watchTyping(String conversationId) {
    _channelFor(conversationId);
    return _controller!.stream;
  }
}
