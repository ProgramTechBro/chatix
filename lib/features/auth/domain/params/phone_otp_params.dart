class PhoneOtpParams {
  const PhoneOtpParams({
    required this.verificationId,
    required this.smsCode,
    required this.phoneNumber,
    required this.name,
  });

  final String verificationId;
  final String smsCode;
  final String phoneNumber;
  final String name;
}
