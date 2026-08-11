import 'package:injectable/injectable.dart';
import '../../domain/entities/voice_waveform_entity.dart';
import '../../domain/repositories/voice_repository.dart';
import '../datasources/local/voice_cache_local_datasource.dart';

@LazySingleton(as: VoiceRepository)
class VoiceRepositoryImpl implements VoiceRepository {
  const VoiceRepositoryImpl(this._localDataSource);

  final VoiceCacheLocalDataSource _localDataSource;

  @override
  Future<VoiceWaveformEntity> getOrExtractWaveform(String audioUrl) {
    return _localDataSource.getOrExtractWaveform(audioUrl);
  }
}
