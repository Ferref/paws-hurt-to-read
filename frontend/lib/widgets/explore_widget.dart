import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../viewmodels/explore_view_model.dart';
import '../models/book.dart';
import 'book_details_widget.dart';

class ExploreWidget extends StatefulWidget {
  final ExploreViewModel vm;

  const ExploreWidget({super.key, required this.vm});

  @override
  State<ExploreWidget> createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> with AutomaticKeepAliveClientMixin {
  // no custom initialization required here; keeping the default behavior

  Widget _buildGrid(List<Book> books) {
    return GridView.builder(
      padding: const EdgeInsets.all(12.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        final title = book.title;
        final cover = book.coverImage;

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookDetailsWidget(bookId: book.id),
              ),
            );
          },
          child: Card(
            color: Colors.white70,
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: cover?.isNotEmpty == true
                      ? Image.network(
                          cover!,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Icon(
                            Icons.book,
                            size: 48,
                            color: Colors.white70,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
                    style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return AnimatedBuilder(
      animation: widget.vm,
      builder: (context, _) {
        if (widget.vm.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (widget.vm.error != null) {
          return Center(child: Text('Error: ${widget.vm.error}'));
        }

        if (!widget.vm.showBooks) {
          return Center(child: Text('Explore', style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20, color: Colors.white))));
        }

        final books = widget.vm.books;
        if (books.isEmpty) {
          return const Center(child: Text('No books available'));
        }

        return _buildGrid(books);
      },
    );
  }
}
