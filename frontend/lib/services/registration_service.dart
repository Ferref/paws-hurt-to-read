import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/models/user.dart';
import 'package:frontend/config/api_routes.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegistrationService {
  final String host = ApiRoutes.basePath;
  final String registrationEndpoint = ApiRoutes.registration;
  final FlutterSecureStorage _storage = getIt<FlutterSecureStorage>();

  Future<User> store({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final uri = Uri.parse('$host/$registrationEndpoint');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode == 422) {
      final body = response.body;
      throw Exception('Validation errors: $body');
    }

    if (response.statusCode != 201) {
      throw Exception('Failed to register user: ${response.statusCode}');
    }

    User user = User.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    return user;
  }
}