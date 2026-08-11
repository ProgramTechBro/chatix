import '../entities/voice_waveform_entity.dart';

abstract class VoiceRepository {
  Future<VoiceWaveformEntity> getOrExtractWaveform(String audioUrl);
}
