import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_chef_app/services/models/user.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unauthenticated() = Unauthenticated;
  const factory AuthState.authenticated(LoginState info) = Authenticated;
  const factory AuthState.error(String message) = AuthError;
}

class LoginState {
  final String token;
  final User? user;

  const LoginState({
    required this.token,
    required this.user,
  });
}
