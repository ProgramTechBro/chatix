import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/constants/hive_boxes.dart';
import '../../models/message_model.dart';
import 'chat_local_datasource.dart';

const _maxCachedMessages = 50;

@LazySingleton(as: ChatLocalDataSource)
class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  Box<String> get _box => Hive.box<String>(HiveBoxes.chatMessagesCache);

  @override
  List<MessageModel> getCached(String conversationId) {
    final raw = _box.get(conversationId);
    if (raw == null) return [];
    final rows = jsonDecode(raw) as List;
    return rows
        .map((row) => MessageModel.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveCache(String conversationId, List<MessageModel> messages) {
    final capped = messages.length > _maxCachedMessages
        ? messages.sublist(messages.length - _maxCachedMessages)
        : messages;
    final rows = capped.map((message) => message.toJson()).toList();
    return _box.put(conversationId, jsonEncode(rows));
  }
}
