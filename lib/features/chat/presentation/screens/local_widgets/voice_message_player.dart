import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/utils/helpers/formatters.dart';
import '../../providers/voice_message_provider.dart';

const _waveformWidth = 140.0;
const _waveformHeight = 32.0;
const _waveformSpacing = 4.0;

class VoiceMessagePlayer extends ConsumerStatefulWidget {
  const VoiceMessagePlayer({
    super.key,
    required this.audioUrl,
    required this.totalDuration,
    required this.color,
    required this.textStyle,
    this.waveformSamples,
  });

  final String audioUrl;
  final Duration totalDuration;
  final Color color;
  final TextStyle? textStyle;
  final List<double>? waveformSamples;

  @override
  ConsumerState<VoiceMessagePlayer> createState() => _VoiceMessagePlayerState();
}

class _VoiceMessagePlayerState extends ConsumerState<VoiceMessagePlayer> {
  final PlayerController _controller = PlayerController();

  bool _isPreparingPlayback = false;
  bool _isPlayerReady = false;
  bool _isPlaying = false;
  bool _isCompleted = false;
  Duration _position = Duration.zero;

  bool get _hasEmbeddedSamples => widget.waveformSamples?.isNotEmpty ?? false;
  bool get _isLocalFile => !widget.audioUrl.startsWith('http');

  @override
  void initState() {
    super.initState();
    _controller.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => _isPlaying = state == PlayerState.playing);
    });
    _controller.onCurrentDurationChanged.listen((ms) {
      if (!mounted) return;
      setState(() => _position = Duration(milliseconds: ms));
    });
    _controller.onCompletion.listen((_) {
      if (!mounted) return;
      setState(() {
        _isPlaying = false;
        _isCompleted = true;
        _position = Duration.zero;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _togglePlayback() async {
    if (_isPlaying) {
      await _controller.pausePlayer();
      return;
    }
    if (!_isPlayerReady) {
      setState(() => _isPreparingPlayback = true);
      final localPath = _isLocalFile
          ? widget.audioUrl
          : (await ref.read(
              voiceMessageProvider(widget.audioUrl).future,
            )).localFilePath;
      await _controller.preparePlayer(
        path: localPath,
        shouldExtractWaveform: false,
      );
      await _controller.setFinishMode(finishMode: FinishMode.pause);
      if (!mounted) return;
      setState(() {
        _isPreparingPlayback = false;
        _isPlayerReady = true;
      });
    }
    if (_isCompleted) {
      await _controller.seekTo(0);
      _isCompleted = false;
    }
    await _controller.startPlayer();
  }

  Widget _buildWaveform(List<double> samples) {
    return AudioFileWaveforms(
      key: ValueKey(widget.audioUrl),
      size: const Size(_waveformWidth, _waveformHeight),
      playerController: _controller,
      waveformData: samples,
      waveformType: WaveformType.fitWidth,
      enableSeekGesture: true,
      animationDuration: const Duration(milliseconds: 1),
      playerWaveStyle: PlayerWaveStyle(
        fixedWaveColor: widget.color.withValues(alpha: 0.35),
        liveWaveColor: widget.color,
        seekLineColor: widget.color,
        spacing: _waveformSpacing,
        waveThickness: 2.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasProgress = _isPlaying || _position > Duration.zero;
    final remaining = widget.totalDuration - _position;
    final displayDuration = hasProgress && !remaining.isNegative
        ? remaining
        : widget.totalDuration;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _isPreparingPlayback ? null : _togglePlayback,
          child: SizedBox(
            width: 32,
            height: 32,
            child: _isPreparingPlayback
                ? Padding(
                    padding: const EdgeInsets.all(6),
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: widget.color,
                    ),
                  )
                : Icon(
                    _isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                    size: 32,
                    color: widget.color,
                  ),
          ),
        ),
        const SizedBox(width: 8),
        _hasEmbeddedSamples
            ? _buildWaveform(widget.waveformSamples!)
            : ref
                  .watch(voiceMessageProvider(widget.audioUrl))
                  .when(
                    data: (waveform) => _buildWaveform(waveform.samples),
                    loading: () => const SizedBox(
                      width: _waveformWidth,
                      height: _waveformHeight,
                    ),
                    error: (error, stackTrace) => const SizedBox(
                      width: _waveformWidth,
                      height: _waveformHeight,
                    ),
                  ),
        const SizedBox(width: 8),
        Text(formatDuration(displayDuration), style: widget.textStyle),
      ],
    );
  }
}
