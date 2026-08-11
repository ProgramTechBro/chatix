import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injectable/injectable.dart';
import '../../models/voice_waveform_model.dart';
import 'voice_cache_local_datasource.dart';

const _waveformSampleCount = 30;

@LazySingleton(as: VoiceCacheLocalDataSource)
class VoiceCacheLocalDataSourceImpl implements VoiceCacheLocalDataSource {
  @override
  Future<VoiceWaveformModel> getOrExtractWaveform(String audioUrl) async {
    final file = await DefaultCacheManager().getSingleFile(audioUrl);
    final samples = await WaveformExtractionController().extractWaveformData(
      path: file.path,
      noOfSamples: _waveformSampleCount,
    );
    return VoiceWaveformModel(localFilePath: file.path, samples: samples);
  }
}
