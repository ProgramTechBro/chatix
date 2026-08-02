import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../models/user_model.dart';
import 'supabase_auth_remote_datasource.dart';

@LazySingleton(as: SupabaseAuthRemoteDataSource)
class SupabaseAuthRemoteDataSourceImpl implements SupabaseAuthRemoteDataSource {
  SupabaseAuthRemoteDataSourceImpl(this._client);

  final SupabaseClient _client;

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = response.user;
    if (user == null) throw ServerException();
    return UserModel.fromSupabaseUser(user);
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    final user = response.user;
    if (user == null) throw ServerException();
    return UserModel.fromSupabaseUser(user);
  }

  @override
  Future<UserModel> bridgePhoneAuth({
    required String phoneNumber,
    required String firebaseIdToken,
    required String name,
  }) async {
    final result = await _client.functions.invoke(
      'bridge-phone-auth',
      body: {
        'phone': phoneNumber,
        'firebaseIdToken': firebaseIdToken,
        'name': name,
      },
    );
    final data = result.data as Map<String, dynamic>;
    final response = await _client.auth.setSession(
      data['refresh_token'] as String,
    );
    final user = response.user;
    if (user == null) throw ServerException();
    return UserModel.fromSupabaseUser(user);
  }

  @override
  Future<UserModel?> restoreSession() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return UserModel.fromSupabaseUser(user);
  }

  @override
  Future<void> signOut() => _client.auth.signOut();

  @override
  Future<void> updateLastSeen() async {
    await _client.rpc('update_last_seen');
  }

  @override
  Future<void> setOffline() async {
    await _client.rpc('set_offline');
  }
}
