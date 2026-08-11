import 'package:injectable/injectable.dart';
import '../entities/voice_waveform_entity.dart';
import '../repositories/voice_repository.dart';

@injectable
class GetOrExtractVoiceWaveformUseCase {
  const GetOrExtractVoiceWaveformUseCase(this._repository);

  final VoiceRepository _repository;

  Future<VoiceWaveformEntity> call(String audioUrl) {
    return _repository.getOrExtractWaveform(audioUrl);
  }
}
