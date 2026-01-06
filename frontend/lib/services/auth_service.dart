import 'dart:convert';

import 'package:frontend/config/api_routes.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:frontend/models/user.dart';

class AuthService {
  final String host = ApiRoutes.basePath;
  final String loginEndpoint = ApiRoutes.login;
  final String logoutEndpoint = ApiRoutes.logout;
  final String refreshEndpoint = ApiRoutes.refresh;
  final String userBooksEndpoint = ApiRoutes.userBooks;

  final FlutterSecureStorage storage = const FlutterSecureStorage();

  late User user;

  Future<User> store({required String name, required String password}) async {
    final uri = Uri.parse('$host/$loginEndpoint');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'password': password}),
    );

    if (response.statusCode == 401) {
      throw Exception(response.body);
    }

    if (response.statusCode != 201) {
      throw Exception('Login failed');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    await storage.write(key: 'refresh_token', value: decoded['refresh_token']);

    user = User.fromJson(decoded);
    return user;
  }

  Future<bool> storeBook({required int bookId}) async {
    final response = await _authPost(userBooksEndpoint, {'bookId': bookId});

    if (response.statusCode != 201) {
      throw Exception('Failed to add book for user');
    }

    return true;
  }

  Future<http.Response> _authPost(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final uri = Uri.parse('$host/$endpoint');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode != 401) {
      return response;
    }

    await _refreshAccessToken();

    return http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${user.accessToken}',
      },
      body: jsonEncode(body),
    );
  }

  Future<void> _refreshAccessToken() async {
    final refreshToken = await storage.read(key: 'refresh_token');

    if (refreshToken == null) {
      throw Exception('Not authenticated');
    }

    final uri = Uri.parse('$host/$refreshEndpoint');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refresh_token': refreshToken}),
    );

    if (response.statusCode != 200) {
      await storage.delete(key: 'refresh_token');
      throw Exception('Session expired');
    }

    final decoded = jsonDecode(response.body);

    user = User(
      id: user.id,
      name: user.name,
      email: user.email,
      accessToken: decoded['access_token'],
    );

    await storage.write(key: 'refresh_token', value: decoded['refresh_token']);
  }

  Future<void> destroy() async {
    final refreshToken = await storage.read(key: 'refresh_token');

    if (refreshToken != null) {
      await http.post(
        Uri.parse('$host/$logoutEndpoint'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );
    }

    await storage.delete(key: 'refresh_token');
  }
}
