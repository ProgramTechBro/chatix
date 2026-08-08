import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/helpers/formatters.dart';

class VoiceMessagePlayer extends StatefulWidget {
  const VoiceMessagePlayer({
    super.key,
    required this.audioUrl,
    required this.totalDuration,
    required this.color,
    required this.textStyle,
  });

  final String audioUrl;
  final Duration totalDuration;
  final Color color;
  final TextStyle? textStyle;

  @override
  State<VoiceMessagePlayer> createState() => _VoiceMessagePlayerState();
}

class _VoiceMessagePlayerState extends State<VoiceMessagePlayer> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _player.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => _isPlaying = state == PlayerState.playing);
    });
    _player.onPositionChanged.listen((position) {
      if (!mounted) return;
      setState(() => _position = position);
    });
    _player.onPlayerComplete.listen((_) {
      if (!mounted) return;
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Future<void> _togglePlayback() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.play(UrlSource(widget.audioUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasProgress = _isPlaying || _position > Duration.zero;
    final remaining = widget.totalDuration - _position;
    final displayDuration = hasProgress && !remaining.isNegative
        ? remaining
        : widget.totalDuration;
    final progress = widget.totalDuration.inMilliseconds == 0
        ? 0.0
        : _position.inMilliseconds / widget.totalDuration.inMilliseconds;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _togglePlayback,
          child: Icon(
            _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
            size: 32,
            color: widget.color,
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 96,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 3,
              backgroundColor: widget.color.withValues(alpha: 0.25),
              valueColor: AlwaysStoppedAnimation<Color>(widget.color),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(formatDuration(displayDuration), style: widget.textStyle),
      ],
    );
  }
}
