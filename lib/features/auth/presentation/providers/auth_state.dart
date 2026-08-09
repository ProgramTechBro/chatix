import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/entities/user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(RequestStatus.initial) RequestStatus status,
    UserEntity? user,
    String? errorMessage,
    String? verificationId,
    @Default(false) bool isNewUser,
  }) = _AuthState;
}
