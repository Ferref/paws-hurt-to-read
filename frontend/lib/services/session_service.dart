import 'dart:convert';

import 'package:frontend/config/api_routes.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/models/user.dart';

class SessionService {
  final String host = ApiRoutes.basePath;
  final String loginEndpoint = ApiRoutes.login;
  final String logoutEndpoint = ApiRoutes.logout;
  final String userBooksEndpoint = ApiRoutes.userBooks;

  // Session Stored (token)
  Future<User> store({required String name, required String password}) async {
    final uri = Uri.parse('$host/$loginEndpoint');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'password': password}),
    );

    if (response.statusCode == 401) {
      final body = response.body;
      throw Exception('Validation errors: $body');
    }

    if (response.statusCode != 201) {
      throw Exception('Failed to login user: ${response.statusCode}');
    }

    User user = User.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );

    return user;
  }

  Future<void> storeBook({required int bookId }) async {
    final uri = Uri.parse('$host/$userBooksEndpoint');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({ 'bookId': bookId }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add book for user: ${response.statusCode}');
    }
  }

  Future<User?> destroy() async {
    // TODO: Token invalidation
    return null;
  }
}