import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:legend_utils/logging/logger.dart';
import 'package:smart_chef_app/services/models/user.dart';

const baseUrl = "https://info.smartchef.ai/auth";

const _authKey = 'auth_token';
const _infoKey = 'auth_info';

const db = FlutterSecureStorage();

class AuthException implements Exception {
  final String message;

  AuthException(this.message);

  @override
  String toString() {
    return message;
  }
}

class AuthService {
  static Future<String> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: getHeaders(),
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    switch (response.statusCode) {
      case 200:
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final token = json['access_token'];
        if (token is! String) throw Exception('Failed to login');

        saveToken(token);
        saveUserInfo(SavedUser(email, password));

        return token;
      case 401:
        throw AuthException('Invalid credentials');
      case 404:
        throw AuthException('User not found');
      default:
        throw AuthException('Failed to login');
    }
  }

  static Future<bool> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: getHeaders(),
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    switch (response.statusCode) {
      case 200:
        return true;
      default:
        final msg = jsonDecode(response.body)['msg'];
        throw AuthException(msg);
    }
  }

  static Future<bool> logout(String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/logout'),
      headers: getHeaders(token),
    );

    _deleteToken();
    return response.statusCode == 200;
  }

  static Future<bool> delete(String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/delete'),
      headers: getHeaders(token),
    );
    return response.statusCode == 200;
  }

  static Future<User?> getUserInfo(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user'),
      headers: getHeaders(token),
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final user = User.fromJson(body);
      return user;
    }
    return null;
  }

  static Map<String, String> getHeaders([String? token]) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  ///
  /// Local storage
  ///

  static void saveToken(String token) {
    db.write(key: _authKey, value: token).then(
          (_) => Logger.log(
            'Saved token $token',
          ),
        );
  }

  static void _deleteToken() {
    db.delete(key: _authKey).then(
          (_) => Logger.log(
            'Deleted token',
          ),
        );
  }

  static void saveUserInfo(SavedUser user) {
    final userString = jsonEncode(user);
    db.write(key: _infoKey, value: userString).then(
          (_) => Logger.log(
            'Saved user info $userString',
          ),
        );
  }

  static Future<SavedUser?> readUser() async {
    final userString = await db.read(key: _infoKey);
    if (userString != null) {
      final user = SavedUser.fromJson(jsonDecode(userString));
      return user;
    }
    return null;
  }

  static Future<bool> deleteInfo() async => Future.wait([
        db.delete(key: _authKey),
        db.delete(key: _infoKey),
      ]).then((_) => true);
}

class SavedUser {
  final String email;
  final String password;

  const SavedUser(this.email, this.password);

  factory SavedUser.fromJson(Map<String, dynamic> json) {
    return SavedUser(
      json['email'] as String,
      json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
