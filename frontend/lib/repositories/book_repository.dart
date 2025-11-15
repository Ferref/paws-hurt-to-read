import 'dart:convert';
import 'package:frontend/models/book_details.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/book.dart';

class BookRepository {
  final String? base = dotenv.env['API_BASE'];
  final String? booksRangeEndpoint = dotenv.env['BOOK_COVERS_ENDPOINT'];
  final String? bookDetailsEndpoint = dotenv.env['BOOK_DETAILS_ENDPOINT'];

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

  Future<BookDetails> fetchBookDetails(String bookId) async {
    final baseVal = base ?? '';
    final endpoint = bookDetailsEndpoint ?? '';
    final uri = Uri.parse('$baseVal/$endpoint/$bookId');

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return BookDetails.fromJson(body as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load book details: ${response.statusCode}');
    }
  }
}
