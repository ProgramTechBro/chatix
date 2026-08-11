import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/constants/hive_boxes.dart';
import '../../models/chat_summary_model.dart';
import 'chat_list_local_datasource.dart';

const _cacheKey = 'chats';

@LazySingleton(as: ChatListLocalDataSource)
class ChatListLocalDataSourceImpl implements ChatListLocalDataSource {
  Box<String> get _box => Hive.box<String>(HiveBoxes.chatListCache);

  @override
  List<ChatSummaryModel> getCached() {
    final raw = _box.get(_cacheKey);
    if (raw == null) return [];
    final rows = jsonDecode(raw) as List;
    return rows
        .map((row) => ChatSummaryModel.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveCache(List<ChatSummaryModel> chats) {
    final rows = chats.map((chat) => chat.toJson()).toList();
    return _box.put(_cacheKey, jsonEncode(rows));
  }
}
