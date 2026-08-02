import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/failures.dart';

AuthFailure mapFirebaseAuthError(Object error) {
  if (error is! FirebaseAuthException) {
    return const AuthFailure('Something went wrong. Please try again.');
  }

  switch (error.code) {
    case 'invalid-verification-code':
      return const AuthFailure('Please enter a valid OTP.');
    case 'invalid-verification-id':
    case 'session-expired':
      return const AuthFailure(
        'This code has expired. Please request a new one.',
      );
    case 'invalid-phone-number':
      return const AuthFailure('Please enter a valid phone number.');
    case 'too-many-requests':
      return const AuthFailure('Too many attempts. Please try again later.');
    case 'quota-exceeded':
      return const AuthFailure(
        'Service temporarily unavailable. Please try again later.',
      );
    case 'user-disabled':
      return const AuthFailure('This account has been disabled.');
    case 'operation-not-allowed':
      return const AuthFailure('Phone sign-in is currently unavailable.');
    case 'credential-already-in-use':
      return const AuthFailure(
        'This phone number is already linked to another account.',
      );
    default:
      return const AuthFailure('Something went wrong. Please try again.');
  }
}
