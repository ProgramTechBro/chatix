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

  @override
  Future<void> add(String conversationId, PendingMessageModel message) async {
    final messages = await getAll(conversationId)
      ..add(message);
    final rows = messages.map((m) => m.toJson()).toList();
    await _box.put(conversationId, jsonEncode(rows));
  }

  @override
  Future<List<PendingMessageModel>> getAll(String conversationId) async {
    final raw = _box.get(conversationId);
    if (raw == null) return [];
    final rows = jsonDecode(raw) as List;
    return rows
        .map((row) => PendingMessageModel.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> clear(String conversationId) {
    return _box.delete(conversationId);
  }
}
