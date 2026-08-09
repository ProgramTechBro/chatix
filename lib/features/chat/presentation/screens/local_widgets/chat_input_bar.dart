import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart' hide Amplitude;
import 'package:waveform_flutter/waveform_flutter.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../core/di/injector.dart';
import '../../../../../core/services/permission_service.dart';
import '../../../../../core/utils/helpers/formatters.dart';

class ChatInputBar extends StatefulWidget {
  const ChatInputBar({
    super.key,
    required this.onSend,
    required this.onSendImage,
    required this.onSendVoice,
    this.onTyping,
  });

  final ValueChanged<String> onSend;
  final ValueChanged<File> onSendImage;
  final void Function(File audioFile, int durationMs) onSendVoice;
  final VoidCallback? onTyping;

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  static const _typingThrottle = Duration(seconds: 2);

  final TextEditingController _controller = TextEditingController();
  final AudioRecorder _recorder = AudioRecorder();

  bool _isRecording = false;
  String? _recordingPath;
  Duration _elapsed = Duration.zero;
  Timer? _timer;
  Stream<Amplitude>? _amplitudeStream;
  DateTime? _lastTypingSentAt;

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    _recorder.dispose();
    super.dispose();
  }

  void _handleTextChanged(String value) {
    final now = DateTime.now();
    if (_lastTypingSentAt == null ||
        now.difference(_lastTypingSentAt!) > _typingThrottle) {
      _lastTypingSentAt = now;
      widget.onTyping?.call();
    }
  }

  void _submit(String value) {
    final text = value.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  Future<void> _pickImage() async {
    final hasPermission = await getIt<PermissionService>().requestGallery();
    if (!hasPermission) return;
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) widget.onSendImage(File(picked.path));
  }

  Future<void> _startRecording() async {
    final hasPermission = await getIt<PermissionService>().requestMicrophone();
    if (!hasPermission) return;

    final directory = await getTemporaryDirectory();
    final path =
        '${directory.path}/${DateTime.now().microsecondsSinceEpoch}.m4a';
    await _recorder.start(const RecordConfig(), path: path);

    setState(() {
      _isRecording = true;
      _recordingPath = path;
      _elapsed = Duration.zero;
      _amplitudeStream = _recorder
          .onAmplitudeChanged(const Duration(milliseconds: 100))
          .map(
            (amplitude) =>
                Amplitude(current: amplitude.current, max: amplitude.max),
          );
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsed += const Duration(seconds: 1));
    });
  }

  Future<void> _cancelRecording() async {
    await _recorder.stop();
    final path = _recordingPath;
    if (path != null) {
      final file = File(path);
      if (await file.exists()) await file.delete();
    }
    _resetRecordingState();
  }

  Future<void> _stopAndSendRecording() async {
    await _recorder.stop();
    final path = _recordingPath;
    final durationMs = _elapsed.inMilliseconds;
    _resetRecordingState();
    if (path != null && durationMs > 0) {
      widget.onSendVoice(File(path), durationMs);
    }
  }

  void _resetRecordingState() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _isRecording = false;
      _recordingPath = null;
      _amplitudeStream = null;
      _elapsed = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.only(left: 10, right: 20),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.textSecondary),
        borderRadius: BorderRadius.circular(55),
      ),
      child: _isRecording
          ? _RecordingRow(
              elapsed: _elapsed,
              amplitudeStream: _amplitudeStream,
              onCancel: _cancelRecording,
              onSend: _stopAndSendRecording,
            )
          : _ComposeRow(
              controller: _controller,
              onChanged: _handleTextChanged,
              onSubmitted: _submit,
              onPickImage: _pickImage,
              onStartRecording: _startRecording,
              onSendTap: () => _submit(_controller.text),
            ),
    );
  }
}

class _ComposeRow extends StatelessWidget {
  const _ComposeRow({
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.onPickImage,
    required this.onStartRecording,
    required this.onSendTap,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onPickImage;
  final VoidCallback onStartRecording;
  final VoidCallback onSendTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onPickImage,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: AppColors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            style: const TextStyle(fontSize: 16),
            textInputAction: TextInputAction.send,
            decoration: const InputDecoration(
              hintText: 'Message...',
              filled: false,

              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onStartRecording,
          child: const Icon(
            Icons.mic_none_outlined,
            color: AppColors.textSecondary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onPickImage,
          child: const Icon(
            Icons.image_outlined,
            color: AppColors.textSecondary,
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onSendTap,
          child: const Icon(
            Icons.send_rounded,
            color: AppColors.primary,
            size: 24,
          ),
        ),
      ],
    );
  }
}

class _RecordingRow extends StatelessWidget {
  const _RecordingRow({
    required this.elapsed,
    required this.amplitudeStream,
    required this.onCancel,
    required this.onSend,
  });

  final Duration elapsed;
  final Stream<Amplitude>? amplitudeStream;
  final VoidCallback onCancel;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        GestureDetector(
          onTap: onCancel,
          child: const Icon(
            Icons.delete_outline_rounded,
            color: AppColors.textSecondary,
            size: 24,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: amplitudeStream == null
              ? const SizedBox.shrink()
              : AnimatedWaveList(
                  stream: amplitudeStream!,
                  barBuilder: (animation, amplitude) => WaveFormBar(
                    animation: animation,
                    amplitude: amplitude,
                    color: AppColors.primary,
                  ),
                ),
        ),
        const SizedBox(width: 10),
        Text(
          formatDuration(elapsed),
          style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(width: 16),
        GestureDetector(
          onTap: onSend,
          child: const Icon(
            Icons.send_rounded,
            color: AppColors.primary,
            size: 24,
          ),
        ),
      ],
    );
  }
}
