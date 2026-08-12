import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/message_entity.dart';

part 'optimistic_messages_provider.g.dart';

@riverpod
class OptimisticMessages extends _$OptimisticMessages {
  @override
  List<MessageEntity> build(String conversationId) => [];

  void add(MessageEntity message) => state = [...state, message];

  void remove(String id) =>
      state = state.where((message) => message.id != id).toList();
}
