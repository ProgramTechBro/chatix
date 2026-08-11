import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/constants/hive_boxes.dart';
import '../../models/pending_message_model.dart';
import 'pending_message_local_datasource.dart';

@LazySingleton(as: PendingMessageLocalDataSource)
class PendingMessageLocalDataSourceImpl
    implements PendingMessageLocalDataSource {
  Box<String> get _box => Hive.box<String>(HiveBoxes.pendingMessagesCache);

  String _key(String conversationId, String messageId) =>
      '$conversationId::$messageId';

  @override
  Future<void> add(String conversationId, PendingMessageModel message) {
    return _box.put(
      _key(conversationId, message.messageId),
      jsonEncode(message.toJson()),
    );
  }

  @override
  Future<List<PendingMessageModel>> getAll(String conversationId) async {
    final prefix = '$conversationId::';
    final entries =
        _box.keys
            .whereType<String>()
            .where((key) => key.startsWith(prefix))
            .map((key) {
              final raw = _box.get(key)!;
              return PendingMessageModel.fromJson(
                jsonDecode(raw) as Map<String, dynamic>,
              );
            })
            .toList()
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return entries;
  }

  @override
  Future<void> clear(String conversationId) {
    final prefix = '$conversationId::';
    final keys = _box.keys.whereType<String>().where(
      (key) => key.startsWith(prefix),
    );
    return _box.deleteAll(keys);
  }
}
