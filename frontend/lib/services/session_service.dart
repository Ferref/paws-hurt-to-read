import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:frontend/models/user.dart';

class SessionService {
  final String host = dotenv.env['API_HOST']!;
  final String loginEndpoint = dotenv.env['LOGIN_PATH']!;
  final String logoutEndpoint = dotenv.env['LOGOUT_PATH']!;
  final String storeBookEndpoint = dotenv.env['STORE_BOOK_PATH']!;

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
    final uri = Uri.parse('$host/$storeBookEndpoint');

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
    // Todo: Token invalidation
    return null;
  }
}
