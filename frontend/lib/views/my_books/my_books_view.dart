import 'package:flutter/material.dart';
import 'package:frontend/models/book_details.dart';

import 'package:frontend/widgets/search_bar_widget.dart';
import 'package:frontend/views/my_books/import_widget.dart';
import 'package:frontend/widgets/books_widget.dart';

// TODO: My books will be displayed here ordered by last_opened
// TODO: If its not downloaded you can download the book to the device
// TODO: If its downloaded to the device you can open it for reading
// TODO: You can remove the book from device
// TODO: You can remove the book from (account + device)

// TODO: Implement search

class MyBooksView extends StatelessWidget {
  const MyBooksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: const SafeArea(child: _MyBooksBody()),
    );
  }
}

class _MyBooksBody extends StatelessWidget {
  const _MyBooksBody();

  // TODO: Replace placeholder
  static const List<BookDetails> _details = [
    BookDetails(
      id: 1,
      title: 'Raven book 1',
      coverImage:
          'https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg',
    ),
    BookDetails(
      id: 2,
      title: 'Raven book 2',
      coverImage:
          'https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg',
    ),
    BookDetails(
      id: 3,
      title: 'Raven book 3',
      coverImage:
          'https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg',
    ),
    BookDetails(
      id: 4,
      title: 'Raven book 4',
      coverImage:
          'https://ebooklaunch.com/wp-content/uploads/2020/10/ravensong_cover6-640x1024.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SearchBarWidget(),
        SizedBox(height: 16),
        Expanded(child: BooksWidget(details: _details)),
        ImportWidget(),
      ],
    );
  }
}





// TODO: Add pagination buttons