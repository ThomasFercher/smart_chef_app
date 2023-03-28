import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smart_chef_app/services/models/user.dart';

const baseUrl = "http://127.0.0.1:5000/auth";

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
}
