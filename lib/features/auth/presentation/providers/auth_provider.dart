import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injector.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/usecases/send_otp_usecase.dart';
import '../../domain/usecases/verify_otp_usecase.dart';
import 'auth_state.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  late final SendOtpUseCase _sendOtp = getIt<SendOtpUseCase>();
  late final VerifyOtpUseCase _verifyOtp = getIt<VerifyOtpUseCase>();

  @override
  AuthState build() => const AuthState();

  Future<void> sendOtp(String phoneNumber) async {
    state = state.copyWith(status: RequestStatus.loading);
    final result = await _sendOtp(phoneNumber);
    result.fold(
      (failure) => state = state.copyWith(
        status: RequestStatus.failure,
        errorMessage: failure.message,
      ),
      (_) => state = state.copyWith(status: RequestStatus.success),
    );
  }

  Future<void> verifyOtp(String code) async {
    state = state.copyWith(status: RequestStatus.loading);
    final result = await _verifyOtp(code);
    result.fold(
      (failure) => state = state.copyWith(
        status: RequestStatus.failure,
        errorMessage: failure.message,
      ),
      (_) => state = state.copyWith(status: RequestStatus.success),
    );
  }
}
