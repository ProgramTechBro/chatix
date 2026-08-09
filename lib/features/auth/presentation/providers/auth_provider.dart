import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/request_status.dart';
import '../../../../core/providers/auth/auth_provider.dart';
import '../../domain/params/email_auth_params.dart';
import '../../domain/params/phone_otp_params.dart';
import '../../domain/usecases/confirm_phone_otp_usecase.dart';
import '../../domain/usecases/sign_in_with_email_usecase.dart';
import '../../domain/usecases/sign_up_with_email_usecase.dart';
import '../../domain/usecases/update_display_name_usecase.dart';
import '../../domain/usecases/verify_phone_number_usecase.dart';
import 'auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final VerifyPhoneNumberUseCase _verifyPhoneNumber =
      getIt<VerifyPhoneNumberUseCase>();
  late final ConfirmPhoneOtpUseCase _confirmPhoneOtp =
      getIt<ConfirmPhoneOtpUseCase>();
  late final SignInWithEmailUseCase _signInWithEmail =
      getIt<SignInWithEmailUseCase>();
  late final SignUpWithEmailUseCase _signUpWithEmail =
      getIt<SignUpWithEmailUseCase>();
  late final UpdateDisplayNameUseCase _updateDisplayName =
      getIt<UpdateDisplayNameUseCase>();

  bool _disposed = false;

  @override
  AuthState build() {
    ref.onDispose(() => _disposed = true);
    return const AuthState();
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    state = state.copyWith(status: RequestStatus.loading, errorMessage: null);
    final result = await _verifyPhoneNumber(phoneNumber);
    if (_disposed) return;
    result.fold(
      (failure) => state = state.copyWith(
        status: RequestStatus.failure,
        errorMessage: failure.message,
      ),
      (verificationId) => state = state.copyWith(
        status: RequestStatus.success,
        verificationId: verificationId,
      ),
    );
  }

  Future<void> confirmPhoneOtp({
    required String smsCode,
    required String phoneNumber,
  }) async {
    final verificationId = state.verificationId;
    if (verificationId == null) return;

    state = state.copyWith(status: RequestStatus.loading, errorMessage: null);
    final result = await _confirmPhoneOtp(
      PhoneOtpParams(
        verificationId: verificationId,
        smsCode: smsCode,
        phoneNumber: phoneNumber,
      ),
    );
    if (_disposed) return;
    result.fold(
      (failure) => state = state.copyWith(
        status: RequestStatus.failure,
        errorMessage: failure.message,
      ),
      (data) {
        state = state.copyWith(
          status: RequestStatus.success,
          user: data.user,
          isNewUser: data.isNewUser,
        );
        ref.read(sessionControllerProvider.notifier).setUser(data.user);
      },
    );
  }

  Future<void> updateDisplayName(String name) async {
    state = state.copyWith(status: RequestStatus.loading, errorMessage: null);
    final result = await _updateDisplayName(name);
    if (_disposed) return;
    result.fold(
      (failure) => state = state.copyWith(
        status: RequestStatus.failure,
        errorMessage: failure.message,
      ),
      (_) => state = state.copyWith(status: RequestStatus.success),
    );
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = state.copyWith(status: RequestStatus.loading, errorMessage: null);
    final result = await _signInWithEmail(
      EmailAuthParams(email: email, password: password),
    );
    if (_disposed) return;
    result.fold(
      (failure) => state = state.copyWith(
        status: RequestStatus.failure,
        errorMessage: failure.message,
      ),
      (user) {
        state = state.copyWith(status: RequestStatus.success, user: user);
        ref.read(sessionControllerProvider.notifier).setUser(user);
      },
    );
  }

  Future<void> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: RequestStatus.loading, errorMessage: null);
    final result = await _signUpWithEmail(
      EmailAuthParams(email: email, password: password, name: name),
    );
    if (_disposed) return;
    result.fold(
      (failure) => state = state.copyWith(
        status: RequestStatus.failure,
        errorMessage: failure.message,
      ),
      (user) {
        state = state.copyWith(status: RequestStatus.success, user: user);
        ref.read(sessionControllerProvider.notifier).setUser(user);
      },
    );
  }
}
