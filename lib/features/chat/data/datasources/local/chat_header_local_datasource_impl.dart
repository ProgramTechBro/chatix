import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/constants/hive_boxes.dart';
import '../../models/chat_header_model.dart';
import 'chat_header_local_datasource.dart';

@LazySingleton(as: ChatHeaderLocalDataSource)
class ChatHeaderLocalDataSourceImpl implements ChatHeaderLocalDataSource {
  Box<String> get _box => Hive.box<String>(HiveBoxes.chatHeaderCache);

  @override
  ChatHeaderModel? getCached(String conversationId) {
    final raw = _box.get(conversationId);
    if (raw == null) return null;
    return ChatHeaderModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  @override
  Future<void> saveCache(String conversationId, ChatHeaderModel header) {
    return _box.put(conversationId, jsonEncode(header.toJson()));
  }
}
