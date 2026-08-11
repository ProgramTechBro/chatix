import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/services/logger_service.dart';
import 'typing_remote_datasource.dart';

@LazySingleton(as: TypingRemoteDataSource)
class TypingRemoteDataSourceImpl implements TypingRemoteDataSource {
  TypingRemoteDataSourceImpl(this._client, this._logger);

  final SupabaseClient _client;
  final LoggerService _logger;
  final Map<String, RealtimeChannel> _channels = {};
  final Map<String, StreamController<void>> _controllers = {};
  final Map<String, Timer> _retryTimers = {};

  String get _currentUserId => _client.auth.currentUser!.id;

  RealtimeChannel _channelFor(String conversationId) {
    return _channels.putIfAbsent(
      conversationId,
      () => _subscribeChannel(conversationId),
    );
  }

  RealtimeChannel _subscribeChannel(String conversationId) {
    final controller = _controllers.putIfAbsent(
      conversationId,
      () => StreamController<void>.broadcast(
        onCancel: () => _teardown(conversationId),
      ),
    );
    return _client
        .channel(
          'conversation:$conversationId',
          opts: const RealtimeChannelConfig(private: true),
        )
        .onBroadcast(
          event: 'typing',
          callback: (payload) {
            if (payload['user_id'] != _currentUserId) controller.add(null);
          },
        )
        .subscribe((status, error) {
          _logger.logInfo(
            'conversation:$conversationId typing subscribe status: $status',
          );
          if (error != null) _logger.logError(error);
          if (status == RealtimeSubscribeStatus.channelError ||
              status == RealtimeSubscribeStatus.timedOut) {
            _channels.remove(conversationId);
            _retryTimers[conversationId]?.cancel();
            _retryTimers[conversationId] = Timer(
              const Duration(seconds: 3),
              () {
                if (_controllers.containsKey(conversationId)) {
                  _channelFor(conversationId);
                }
              },
            );
          }
        });
  }

  void _teardown(String conversationId) {
    _retryTimers.remove(conversationId)?.cancel();
    final channel = _channels.remove(conversationId);
    if (channel != null) _client.removeChannel(channel);
    _controllers.remove(conversationId)?.close();
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
    return _controllers[conversationId]!.stream;
  }
}
