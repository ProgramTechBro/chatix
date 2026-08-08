import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class PermissionService {
  Future<bool> requestMicrophone() => _request(Permission.microphone);

  Future<bool> requestNotifications() => _request(Permission.notification);

  Future<bool> requestCamera() => _request(Permission.camera);

  Future<bool> requestGallery() async {
    if (Platform.isAndroid) {
      final sdkInt = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
      if (sdkInt >= 33) return true;
      return _requestWithLimited(Permission.storage);
    }
    return _requestWithLimited(Permission.photos);
  }

  Future<bool> _request(Permission permission) async {
    final status = await permission.status;
    if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }
    if (status.isGranted) return true;
    final result = await permission.request();
    return result.isGranted;
  }

  Future<bool> _requestWithLimited(Permission permission) async {
    final status = await permission.status;
    if (status.isPermanentlyDenied) {
      openAppSettings();
      return false;
    }
    if (status.isGranted || status.isLimited) return true;
    final result = await permission.request();
    return result.isGranted || result.isLimited;
  }
}
