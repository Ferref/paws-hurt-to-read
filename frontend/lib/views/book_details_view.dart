import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:frontend/main.dart';

import 'package:frontend/models/book_details.dart';
import 'package:frontend/viewmodels/book_details_view_model.dart';

class BookDetailsView extends StatefulWidget {
  final int bookId;

  const BookDetailsView({super.key, required this.bookId});

  @override
  State<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends State<BookDetailsView> {
  final BookDetailsViewModel _vm = getIt<BookDetailsViewModel>();
  final int leadingCharactersInSummary = 1;

  @override
  void initState() {
    super.initState();
    _vm.fetchBookDetails(widget.bookId.toString());
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _vm,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
              'Book Details',
              style: GoogleFonts.lato(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black,
          body: _buildBody(context),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_vm.isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.white));
    }

    if (_vm.errorMessage != null) {
      return Center(
          child: Text('Error: ${_vm.errorMessage}', style: TextStyle(color: Colors.redAccent)));
    }

    final BookDetails? details = _vm.bookDetails;
    if (details == null) {
      return const Center(child: Text('No details available', style: TextStyle(color: Colors.white70)));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (details.coverImage != null && details.coverImage!.isNotEmpty)
            Center(
              child: Image.network(
                details.coverImage!,
                height: 300,
                fit: BoxFit.contain,
              ),
            ),
          const SizedBox(height: 20),
          Text(
            details.title,
            style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          if (details.authors.isNotEmpty)
            Text(
              'By: ${details.authors.map((author) => author['name'].toString()).join(', ')}',
              style: GoogleFonts.lato(fontSize: 14, color: Colors.white70),
            ),
          if (details.downloadCount != null)
            Text(
              'Downloads: ${details.downloadCount}',
              style: GoogleFonts.lato(fontSize: 14, color: Colors.white70),
            ),
          if (details.readingEaseScore != null)
            Text(
              'Readability: ${details.readingEaseScore}',
              style: GoogleFonts.lato(fontSize: 14, color: Colors.white70),
            ),
          const SizedBox(height: 12),
          if (details.summary != null && details.summary!.isNotEmpty)
            Text(
              details.summary!.substring(leadingCharactersInSummary),
              style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
            )
          else
            const Text(
              'No summary available.',
              style: TextStyle(color: Colors.white70),
            ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                if (details.formats['application/epub+zip'] != null)
                  InkWell(
                    onTap: () => {
                      // TODO: user_books table => sessionVm.storeBook(bookId: widget.bookId)
                      // TODO: download book on the device in epub format
                    },
                    child: Chip(
                      backgroundColor: Colors.black87,
                      avatar: const Icon(Icons.book, color: Colors.white),
                      label: Text('Download to My Books', style: TextStyle(color: Colors.white)),
                      // TODO: add book to my account button
                      // TODO: add book to my account implementation
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
