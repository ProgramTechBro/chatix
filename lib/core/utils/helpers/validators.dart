bool isValidEmail(String value) {
  return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value);
}

bool isValidPhoneNumber(String value) {
  return RegExp(r'^\+?[1-9]\d{7,14}$').hasMatch(value);
}

String? nameValidator(String? value) {
  if (value == null || value.trim().isEmpty) return 'Please enter your name';
  return null;
}

String? emailValidator(String? value) {
  final trimmed = value?.trim() ?? '';
  if (trimmed.isEmpty) return 'Please enter your email';
  if (!isValidEmail(trimmed)) return 'Please enter a valid email';
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) return 'Please enter your password';
  if (value.length < 6) return 'Password must be at least 6 characters';
  return null;
}

String? confirmPasswordValidator(String? value, String password) {
  if (value == null || value.isEmpty) return 'Please confirm your password';
  if (value != password) return 'Passwords do not match';
  return null;
}

String? phoneValidator(String? value) {
  final trimmed = value?.trim() ?? '';
  if (trimmed.isEmpty) return 'Please enter your phone number';
  if (!isValidPhoneNumber(trimmed)) return 'Please enter a valid phone number';
  return null;
}
