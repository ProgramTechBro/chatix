import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class PermissionService {
  Future<bool> requestCamera() => _request(Permission.camera);

  Future<bool> requestMicrophone() => _request(Permission.microphone);

  Future<bool> requestNotifications() => _request(Permission.notification);

  Future<bool> _request(Permission permission) async {
    final status = await permission.status;
    if (status.isGranted) return true;
    final result = await permission.request();
    return result.isGranted;
  }
}
