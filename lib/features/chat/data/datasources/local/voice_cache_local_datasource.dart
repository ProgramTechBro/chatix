import '../../models/voice_waveform_model.dart';

abstract class VoiceCacheLocalDataSource {
  Future<VoiceWaveformModel> getOrExtractWaveform(String audioUrl);
}
