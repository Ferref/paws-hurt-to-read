import 'dart:convert';

import 'package:frontend/main.dart';
import 'package:http/http.dart' as http;

import 'package:frontend/services/auth_service.dart';

import 'package:frontend/config/api_routes.dart';
import 'package:frontend/models/book_details.dart';
import 'package:frontend/models/book.dart';

class BookService {
  final String host = ApiRoutes.basePath;
  final String bookCoversEndpoint = ApiRoutes.bookCovers;
  final String bookDetailsEndpoint = ApiRoutes.bookDetails;
  final AuthService _authService = getIt<AuthService>();

  Future<List<Book>> fetchRange({int start = 1, int end = 10}) async {
    final range = '$start-$end';
    final endpoint = bookCoversEndpoint.replaceAll('/{range}', '');
    final uri = Uri.parse('$host/$endpoint/$range');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_authService.user.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body is List) {
        return body
            .map((e) => Book.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  Future<BookDetails> fetchBookDetails(String bookId) async {
    final endpoint = bookDetailsEndpoint.replaceAll('/{id}', '/$bookId');
    final uri = Uri.parse('$host/$endpoint');

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_authService.user.accessToken}',
      },
    );
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return BookDetails.fromJson(body as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load book details: ${response.statusCode}');
    }
  }
}
