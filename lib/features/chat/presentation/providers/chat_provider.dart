import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/message_entity.dart';
import '../../domain/usecases/watch_messages_usecase.dart';

part 'chat_provider.g.dart';

@riverpod
Stream<List<MessageEntity>> chatMessages(ChatMessagesRef ref, String chatId) {
  return getIt<WatchMessagesUseCase>().call(chatId);
}
