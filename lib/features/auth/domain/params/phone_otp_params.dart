class PhoneOtpParams {
  const PhoneOtpParams({
    required this.verificationId,
    required this.smsCode,
    required this.phoneNumber,
  });

  final String verificationId;
  final String smsCode;
  final String phoneNumber;
}
