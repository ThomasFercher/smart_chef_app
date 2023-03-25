import 'package:flutter_test/flutter_test.dart';
import 'package:legend_utils/logging/logger.dart';
import 'package:smart_chef_app/services/auth_service.dart';

const email = 'test@example.com';
const password = 'password';

void main() {
  // Get User Info
  test("Setup a whole User and test every Function", () async {
    // Register Random User
    try {
      final email = "test${DateTime.now().microsecondsSinceEpoch}@example.com";
      final password = "${DateTime.now().millisecondsSinceEpoch}";

      final success = await AuthService.register(email, password);

      expect(success, isTrue);

      Logger.logFetch("Register Success: $success");

      // Login User

      var token = await AuthService.login(email, password);

      expect(token, isNotEmpty);

      Logger.logFetch("Login Succes Token: $token");

      // Get User Info

      final user = await AuthService.getUserInfo(token);
      expect(user, isNotNull);
      Logger.logFetch("User: ${user!.toJson()}}");
      // Logout User

      final logoutSuccess = await AuthService.logout(token);

      expect(logoutSuccess, isTrue);
      Logger.logFetch("Logout Success: $logoutSuccess");
      // Log User in again

      token = await AuthService.login(email, password);

      expect(token, isNotEmpty);
      Logger.logFetch("Login Succes Token: $token");

      // Delete User

      final deleteSuccess = await AuthService.delete(token);

      expect(deleteSuccess, isTrue);

      Logger.logFetch("Delete Success: $deleteSuccess");
    } catch (e, s) {
      Logger.logError(e, s, "Error in Auth Test");
    }
  });
}
