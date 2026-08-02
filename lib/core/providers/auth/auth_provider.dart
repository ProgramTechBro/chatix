import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../features/auth/domain/entities/user_entity.dart';
import '../../../features/auth/domain/usecases/restore_session_usecase.dart';
import '../../../features/auth/domain/usecases/set_offline_usecase.dart';
import '../../../features/auth/domain/usecases/sign_out_usecase.dart';
import '../../../features/auth/domain/usecases/update_last_seen_usecase.dart';
import '../../../features/notifications/domain/entities/device_token_entity.dart';
import '../../../features/notifications/domain/usecases/save_device_token_usecase.dart';
import '../../di/injector.dart';
import '../../services/push_notification_service.dart';

part 'auth_provider.g.dart';

@riverpod
class SessionController extends _$SessionController {
  Timer? _presenceTimer;

  @override
  UserEntity? build() {
    ref.onDispose(() => _presenceTimer?.cancel());
    return null;
  }

  Future<void> restore() async {
    final result = await getIt<RestoreSessionUseCase>().call();
    result.fold((failure) => state = null, (user) {
      state = user;
      if (user != null) {
        _startPresenceHeartbeat();
        _registerDeviceToken(user.id);
      }
    });
  }

  void setUser(UserEntity user) {
    state = user;
    _startPresenceHeartbeat();
    _registerDeviceToken(user.id);
  }

  Future<void> signOut() async {
    _stopPresenceHeartbeat();
    await getIt<SignOutUseCase>().call();
    state = null;
  }

  void onAppResumed() {
    if (state != null) _startPresenceHeartbeat();
  }

  void onAppPaused() {
    if (state != null) _stopPresenceHeartbeat();
  }

  void _startPresenceHeartbeat() {
    _presenceTimer?.cancel();
    getIt<UpdateLastSeenUseCase>().call();
    _presenceTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      getIt<UpdateLastSeenUseCase>().call();
    });
  }

  void _stopPresenceHeartbeat() {
    _presenceTimer?.cancel();
    _presenceTimer = null;
    getIt<SetOfflineUseCase>().call();
  }

  Future<void> _registerDeviceToken(String userId) async {
    final String platform;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      platform = 'ios';
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      platform = 'android';
    } else {
      return;
    }

    final token = await getIt<PushNotificationService>().getToken();
    if (token == null) return;

    await getIt<SaveDeviceTokenUseCase>().call(
      DeviceTokenEntity(userId: userId, token: token, platform: platform),
    );
  }
}

@riverpod
String? currentUserId(CurrentUserIdRef ref) =>
    ref.watch(sessionControllerProvider)?.id;
