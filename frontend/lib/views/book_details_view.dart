import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:frontend/main.dart';

import 'package:frontend/models/book_details.dart';
import 'package:frontend/viewmodels/book_details_view_model.dart';
import 'package:frontend/views/main_home_view.dart';

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
            iconTheme: IconThemeData(
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
            title: Text(
              'Book Details',
              style: GoogleFonts.lato(
                color: Theme.of(context).appBarTheme.foregroundColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          body: _buildBody(context),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_vm.isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).appBarTheme.foregroundColor,
        ),
      );
    }

    if (_vm.errorMessage != null) {
      return Center(
        child: Text(
          'Error: ${_vm.errorMessage}',
          style: TextStyle(color: Colors.redAccent),
        ),
      );
    }

    final BookDetails? details = _vm.bookDetails;
    if (details == null) {
      return Center(
        child: Text(
          'No details available',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
      );
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
            style: GoogleFonts.lato(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
          ),
          const SizedBox(height: 20),
          if (details.authors.isNotEmpty)
            Text(
              'By: ${details.authors.map((author) => author['name'].toString()).join(', ')}',
              style: GoogleFonts.lato(
                fontSize: 14,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
            ),
          if (details.downloadCount != null)
            Text(
              'Downloads: ${details.downloadCount}',
              style: GoogleFonts.lato(
                fontSize: 14,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
            ),
          if (details.readingEaseScore != null)
            Text(
              'Readability: ${details.readingEaseScore}',
              style: GoogleFonts.lato(
                fontSize: 14,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
            ),
          const SizedBox(height: 12),
          if (details.summary != null && details.summary!.isNotEmpty)
            Text(
              details.summary!.substring(leadingCharactersInSummary),
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
            )
          else
            Text(
              'No summary available.',
              style: TextStyle(
                color: Theme.of(context).appBarTheme.foregroundColor,
              ),
            ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                if (details.formats['application/epub+zip'] != null)
                  InkWell(
                    onTap: () async {
                      final bool success = await _vm.storeBook(widget.bookId);

                      if (!mounted) {
                        return;
                      }

                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainHomeView(),
                          ),
                        );
                      }

                      // TODO: download book on the device in epub format
                    },
                    child: Chip(
                      backgroundColor: Theme.of(
                        context,
                      ).appBarTheme.backgroundColor,
                      avatar: Icon(
                        Icons.book,
                        color: Theme.of(context).appBarTheme.backgroundColor,
                      ),
                      label: Text(
                        'Download to My Books',
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).navigationBarTheme.backgroundColor,
                        ),
                      ),
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
