import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/user.dart';

class LoginService {
  final String host = dotenv.env['API_HOST']!;
  final String loginEndpoint = dotenv.env['LOGIN_PATH']!;

  // Session Stored (token)
  Future<User> store({
    required String name,
    required String password,
  }) async {
    final uri = Uri.parse('$host/$loginEndpoint');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'password': password,
      }),
    );

    if (response.statusCode == 401) {
      final body = response.body;
      throw Exception('Validation errors: $body');
    }

    if (response.statusCode != 201) {
      throw Exception('Failed to login user: ${response.statusCode}');
    }

    User user = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    return user;
  }
}