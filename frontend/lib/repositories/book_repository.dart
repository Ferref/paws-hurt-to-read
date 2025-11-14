import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/book.dart';

class BookRepository {
  final String? base = dotenv.env['API_BASE'];
  final String? booksRangeEndpoint = dotenv.env['BOOK_COVERS_ENDPOINT'];

  Future<List<Book>> fetchRange({int start = 1, int end = 10}) async {
    final baseVal = base ?? '';
    final endpoint = booksRangeEndpoint ?? '';
    final uri = Uri.parse('$baseVal/$endpoint/$start-$end');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      if (body is List) {
        return body.map((e) => Book.fromJson(e as Map<String, dynamic>)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
