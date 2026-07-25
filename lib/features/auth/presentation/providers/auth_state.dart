import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/enums/request_status.dart';
import '../../domain/entities/auth_user_entity.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(RequestStatus.initial) RequestStatus status,
    AuthUserEntity? user,
    String? errorMessage,
  }) = _AuthState;
}
