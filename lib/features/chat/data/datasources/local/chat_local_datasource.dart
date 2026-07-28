import 'dart:async';
import 'package:injectable/injectable.dart';
import '../../models/message_model.dart';

abstract class ChatLocalDataSource {
  Stream<List<MessageModel>> watchMessages(String chatId);
  Future<void> sendMessage(String chatId, String text);
}

@LazySingleton(as: ChatLocalDataSource)
class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final Map<String, List<MessageModel>> _messagesByChatId = {};
  final Map<String, StreamController<List<MessageModel>>> _controllers = {};

  List<MessageModel> _seedMessages() => const [
        MessageModel(id: 'm1', text: 'Hello how are you?', isMine: false, time: '10:12'),
        MessageModel(id: 'm2', text: 'I am fine man', isMine: true, time: '10:13'),
        MessageModel(id: 'm3', text: 'Hello how are you?', isMine: false, time: '10:14'),
        MessageModel(id: 'm4', text: 'And I hear something really Good about you', isMine: false, time: '10:15'),
        MessageModel(id: 'm5', text: 'That is so great to hear', isMine: true, time: '10:16'),
        MessageModel(id: 'm6', text: 'And I hear something really Good about you', isMine: false, time: '10:17'),
        MessageModel(id: 'm7', text: 'No way you saying it again man', isMine: true, time: '10:18'),
        MessageModel(id: 'm8', text: 'How is it going', isMine: false, time: '10:19'),
        MessageModel(id: 'm9', text: 'So much fine', isMine: true, time: '10:20'),
        MessageModel(id: 'm10', text: 'Are you okay?', isMine: false, time: '10:21'),
        MessageModel(id: 'm11', text: 'Yeah just want to see you', isMine: true, time: '10:22'),
      ];

  StreamController<List<MessageModel>> _controllerFor(String chatId) {
    return _controllers.putIfAbsent(chatId, () {
      _messagesByChatId.putIfAbsent(chatId, _seedMessages);
      return StreamController<List<MessageModel>>.broadcast();
    });
  }

  @override
  Stream<List<MessageModel>> watchMessages(String chatId) async* {
    final controller = _controllerFor(chatId);
    yield _messagesByChatId[chatId]!;
    yield* controller.stream;
  }

  @override
  Future<void> sendMessage(String chatId, String text) async {
    final controller = _controllerFor(chatId);
    final updated = [
      ..._messagesByChatId[chatId]!,
      MessageModel(id: DateTime.now().microsecondsSinceEpoch.toString(), text: text, isMine: true, time: 'Now'),
    ];
    _messagesByChatId[chatId] = updated;
    controller.add(updated);
  }
}
