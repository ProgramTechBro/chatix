import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/helpers/network_helpers.dart';

AuthFailure mapSupabaseAuthError(Object error) {
  if (isNetworkError(error)) {
    return const AuthFailure(
      'No internet connection. Please check your network and try again.',
    );
  }

  if (error is AuthException) {
    final message = error.message.toLowerCase();
    if (message.contains('invalid login credentials')) {
      return const AuthFailure('Incorrect email or password.');
    }
    if (message.contains('email not confirmed')) {
      return const AuthFailure('Please confirm your email before logging in.');
    }
    if (message.contains('user already registered')) {
      return const AuthFailure('An account with this email already exists.');
    }
    if (message.contains('password should be at least')) {
      return const AuthFailure('Password must be at least 6 characters.');
    }
    return const AuthFailure('Something went wrong. Please try again.');
  }

  if (error is PostgrestException) {
    if (error.code == '23505') {
      return const AuthFailure(
        'This phone number or email is already registered.',
      );
    }
    return const AuthFailure('Something went wrong. Please try again.');
  }

  return const AuthFailure('Something went wrong. Please try again.');
}
