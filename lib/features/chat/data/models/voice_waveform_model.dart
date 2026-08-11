import '../../domain/entities/voice_waveform_entity.dart';

class VoiceWaveformModel extends VoiceWaveformEntity {
  const VoiceWaveformModel({
    required super.localFilePath,
    required super.samples,
  });
}
