import '../../domain/entities/device_token_entity.dart';

class DeviceTokenModel extends DeviceTokenEntity {
  const DeviceTokenModel({
    required super.userId,
    required super.token,
    required super.platform,
  });
}
