import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List<dynamic>> fetchData() async {
    final base = dotenv.env['API_BASE'];
    final booksRangeEndpoint = dotenv.env['BOOK_COVERS_ENDPOINT'];
    
    int start = 1;
    int end = 10;

    final uri = Uri.parse('$base/$booksRangeEndpoint/$start-$end');
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.data == null) {
          return const Center(child: Text('No data found'));
        }
        final books = snapshot.data!;

        if (books.isEmpty) {
          return const Center(child: Text('No books available'));
        }

        return ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index] as Map<String, dynamic>;
            final title = book['title']?.toString() ?? 'Untitled';
            final cover = book['cover_image']?.toString() ?? '';

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: Text(title, style: GoogleFonts.lato(fontSize: 24, fontWeight: FontWeight.bold)),
                ),
                if (cover.isNotEmpty)
                  Image.network(cover)
                else
                  const SizedBox.shrink(),
              ],
            );
          },
        );

      },
    );
  }
}