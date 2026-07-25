class AuthUserEntity {
  final String id;
  final String? phoneNumber;
  final String? email;

  const AuthUserEntity({required this.id, this.phoneNumber, this.email});
}
