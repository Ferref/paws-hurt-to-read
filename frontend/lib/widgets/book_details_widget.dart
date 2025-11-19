import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/book_details_view_model.dart';
import '../models/book_details.dart';

class BookDetailsWidget extends StatefulWidget {
  final int bookId;

  const BookDetailsWidget({super.key, required this.bookId});

  @override
  State<BookDetailsWidget> createState() => _BookDetailsWidgetState();
}

class _BookDetailsWidgetState extends State<BookDetailsWidget> {
  final BookDetailsViewModel _vm = BookDetailsViewModel();

  @override
  void initState() {
    super.initState();
    // fetch details using the view model; repository expects a String id
    _vm.fetchBookDetails(widget.bookId.toString());
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

  final int leadingCharactersInSummary = 1;
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
          body: _buildBody(),
        );
      },
    );
  }

  Widget _buildBody() {
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
          const SizedBox(height: 12),
          Text(
            details.title,
            style: GoogleFonts.lato(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          if (details.authors.isNotEmpty)
            Text(
              'By: ${details.authors.map((author) => author['name'].toString()).join(', ')}',
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
          const SizedBox(height: 12),
          Row(
            children: [
              if (details.downloadCount != null)
                Chip(
                  backgroundColor: Colors.black87,
                  label: Text('Downloads: ${details.downloadCount}', style: TextStyle(color: Colors.white)),
                ),
              const SizedBox(width: 8),
              if (details.readingEaseScore != null)
                Chip(
                  backgroundColor: Colors.black87,
                  label: Text('Readability: ${details.readingEaseScore}', style: TextStyle(color: Colors.white)),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
