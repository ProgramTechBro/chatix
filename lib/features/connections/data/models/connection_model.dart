import '../../domain/entities/connection_entity.dart';

class ConnectionModel extends ConnectionEntity {
  const ConnectionModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
  });
}
