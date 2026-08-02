import '../../models/user_model.dart';

abstract class SupabaseAuthRemoteDataSource {
  Future<UserModel> signInWithEmail(String email, String password);

  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  Future<UserModel> bridgePhoneAuth({
    required String phoneNumber,
    required String firebaseIdToken,
    required String name,
  });

  Future<UserModel?> restoreSession();

  Future<void> signOut();

  Future<void> updateLastSeen();

  Future<void> setOffline();
}
