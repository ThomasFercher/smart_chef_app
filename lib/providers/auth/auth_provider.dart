import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_chef_app/providers/auth/auth_state.dart';
import 'package:smart_chef_app/services/auth_service.dart';

const LOGIN = true;
const debugProfile = SavedUser("test@smartchef.ai", "test#420");

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState.unauthenticated()) {
    if (LOGIN) {
      login(debugProfile.email, debugProfile.password);
    }
  }

  Future<AuthState> login(final String email, final String password) async {
    try {
      final token = await AuthService.login(email, password);
      final user = await AuthService.getUserInfo(token);
      state = AuthState.authenticated(LoginState(token: token, user: user));
    } catch (e) {
      state = AuthState.error(e.toString());
    }
    return state;
  }

  Future<bool> register(final String email, final String password) async {
    return await AuthService.register(email, password);
  }

  Future<bool> logout() async {
    if (state is Authenticated) {
      final success = await AuthService.logout(
        (state as Authenticated).info.token,
      );
      if (success) state = const AuthState.unauthenticated();

      return success;
    }
    return false;
  }

  Future<bool> deleteAccount() async {
    if (state is Authenticated) {
      return AuthService.delete((state as Authenticated).info.token);
    }
    return false;
  }
}
