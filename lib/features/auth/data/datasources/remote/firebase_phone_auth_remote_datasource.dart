abstract class FirebasePhoneAuthRemoteDataSource {
  Future<String> verifyPhoneNumber(String phoneNumber);

  Future<String> confirmOtp(String verificationId, String smsCode);
}
