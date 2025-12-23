
import 'package:flutter/material.dart';
import 'package:frontend/models/book_details.dart';

import 'package:frontend/common/book_card.dart';



class BooksWidget extends StatelessWidget {
  const BooksWidget({super.key, required this.details});

  final List<BookDetails> details;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 2 / 3,
      crossAxisCount: 2,
      padding: const EdgeInsets.all(16),
      crossAxisSpacing: 12,
      mainAxisSpacing: 20,
      children: details.map((book) {
        return BookCard(book: book);
      }).toList(),
    );
  }
}

