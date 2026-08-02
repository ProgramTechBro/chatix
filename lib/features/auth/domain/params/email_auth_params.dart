class EmailAuthParams {
  const EmailAuthParams({
    required this.email,
    required this.password,
    this.name,
  });

  final String email;
  final String password;
  final String? name;
}
