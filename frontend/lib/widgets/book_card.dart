import 'package:flutter/material.dart';

import 'package:frontend/models/book_details.dart' show BookDetails;

import 'package:frontend/utils/formatter.dart';
import 'package:google_fonts/google_fonts.dart';

class BookCard extends StatelessWidget {
  final BookDetails book;
  final int displayCharacters = 20;

  const BookCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(book.coverImage.toString(), fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                Formatter.truncateText(book.title, displayCharacters),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
