class DeviceTokenEntity {
  const DeviceTokenEntity({
    required this.userId,
    required this.token,
    required this.platform,
  });

  final String userId;
  final String token;
  final String platform;
}
