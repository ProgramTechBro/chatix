class VoiceWaveformEntity {
  const VoiceWaveformEntity({
    required this.localFilePath,
    required this.samples,
  });

  final String localFilePath;
  final List<double> samples;
}
