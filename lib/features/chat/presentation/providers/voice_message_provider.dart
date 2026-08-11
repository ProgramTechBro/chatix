import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../domain/entities/voice_waveform_entity.dart';
import '../../domain/usecases/get_or_extract_voice_waveform_usecase.dart';

part 'voice_message_provider.g.dart';

@Riverpod(keepAlive: true)
Future<VoiceWaveformEntity> voiceMessage(VoiceMessageRef ref, String audioUrl) {
  return getIt<GetOrExtractVoiceWaveformUseCase>().call(audioUrl);
}
