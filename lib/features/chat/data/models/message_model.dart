import '../../../../core/enums/message_status.dart';
import '../../../../core/enums/message_type.dart';
import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.conversationId,
    required super.senderId,
    required super.type,
    super.text,
    super.mediaUrl,
    super.mediaDurationMs,
    required super.status,
    required super.createdAt,
    super.waveformSamples,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String,
      conversationId: json['conversation_id'] as String,
      senderId: json['sender_id'] as String,
      type: MessageType.values.byName(json['type'] as String),
      text: json['text'] as String?,
      mediaUrl: json['media_url'] as String?,
      mediaDurationMs: json['media_duration_ms'] as int?,
      status: MessageStatus.values.byName(json['status'] as String),
      createdAt: DateTime.parse(json['created_at'] as String).toLocal(),
      waveformSamples: (json['waveform_samples'] as List?)
          ?.map((sample) => (sample as num).toDouble())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'sender_id': senderId,
      'type': type.name,
      'text': text,
      'media_url': mediaUrl,
      'media_duration_ms': mediaDurationMs,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
      'waveform_samples': waveformSamples,
    };
  }
}
