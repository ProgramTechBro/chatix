import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart' show BlurHash;
import 'package:intl/intl.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../core/enums/message_type.dart';
import '../../../../../core/shared_widgets/app_avatar.dart';
import '../../../domain/entities/message_entity.dart';
import 'voice_message_player.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isMine,
    this.avatarUrl,
  });

  final MessageEntity message;
  final bool isMine;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bubbleColor = isMine ? AppColors.primary : AppColors.surface;
    final textStyle = isMine
        ? textTheme.labelMedium
        : textTheme.labelMedium?.copyWith(color: AppColors.black);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: isMine
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMine) ...[
            avatarUrl != null
                ? AppAvatar(imageUrl: avatarUrl!, radius: 16)
                : const CircleAvatar(radius: 16),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.72,
              ),
              padding: message.type == MessageType.image
                  ? const EdgeInsets.all(4)
                  : const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _MessageContent(message: message, textStyle: textStyle),
                  Padding(
                    padding: const EdgeInsets.only(top: 4, right: 4),
                    child: Text(
                      DateFormat('h:mm a').format(message.createdAt),
                      style: textTheme.bodySmall?.copyWith(
                        color: isMine
                            ? AppColors.white.withValues(alpha: 0.7)
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageContent extends StatelessWidget {
  const _MessageContent({required this.message, required this.textStyle});

  final MessageEntity message;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    switch (message.type) {
      case MessageType.image:
        final mediaUrl = message.mediaUrl!;
        final isLocalFile = !mediaUrl.startsWith('http');
        return AspectRatio(
          aspectRatio: 4 / 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                isLocalFile
                    ? Image.file(File(mediaUrl), fit: BoxFit.cover)
                    : CachedNetworkImage(
                        imageUrl: mediaUrl,
                        fit: BoxFit.cover,
                        fadeInDuration: const Duration(milliseconds: 200),
                        fadeOutDuration: Duration.zero,
                        placeholder: (context, url) => message.blurHash != null
                            ? BlurHash(
                                hash: message.blurHash!,
                                color: AppColors.divider,
                              )
                            : Container(color: AppColors.divider),
                      ),
                if (message.isSending)
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  ),
              ],
            ),
          ),
        );
      case MessageType.voice:
        return VoiceMessagePlayer(
          audioUrl: message.mediaUrl!,
          totalDuration: Duration(milliseconds: message.mediaDurationMs ?? 0),
          color: textStyle?.color ?? AppColors.black,
          textStyle: textStyle,
          waveformSamples: message.waveformSamples,
        );
      case MessageType.text:
        return Text(message.text ?? '', style: textStyle);
    }
  }
}
