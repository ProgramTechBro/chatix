import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/device_token_model.dart';

abstract class FcmTokenDataSource {
  Future<void> saveDeviceToken(DeviceTokenModel token);
}

@LazySingleton(as: FcmTokenDataSource)
class FcmTokenDataSourceImpl implements FcmTokenDataSource {
  FcmTokenDataSourceImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<void> saveDeviceToken(DeviceTokenModel token) async {
    await _client.from('device_tokens').upsert({
      'user_id': token.userId,
      'fcm_token': token.token,
      'platform': token.platform,
      'updated_at': DateTime.now().toIso8601String(),
    }, onConflict: 'user_id,platform');
  }
}
