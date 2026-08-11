import '../../../../core/enums/message_type.dart';

class SendMessageParams {
  const SendMessageParams({
    required this.id,
    required this.conversationId,
    required this.type,
    this.text,
    this.mediaUrl,
    this.mediaDurationMs,
    this.waveformSamples,
  });

  final String id;
  final String conversationId;
  final MessageType type;
  final String? text;
  final String? mediaUrl;
  final int? mediaDurationMs;
  final List<double>? waveformSamples;
}
