import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend/common/search_bar_widget.dart';
import 'package:frontend/models/book.dart';
import 'package:frontend/views/book_details_view.dart';
import 'package:frontend/viewmodels/explore_view_model.dart';

class ExploreView extends StatefulWidget {
  final ExploreViewModel vm;

  const ExploreView({super.key, required this.vm});

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

// TODO: Implement search

class _ExploreViewState extends State<ExploreView>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _scroll;

  @override
  void initState() {
    super.initState();
    widget.vm.ensureLoaded();
    _scroll = ScrollController()
      ..addListener(() {
        if (_scroll.position.pixels >=
            _scroll.position.maxScrollExtent - 300) {
          widget.vm.loadNext();
        }
      });
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  Widget _buildGrid(List<Book> books) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: Column(
        children: [
          const SearchBarWidget(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: widget.vm.refresh,
              child: GridView.builder(
                controller: _scroll,
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
                  final cover = book.coverImage;
                    
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookDetailsView(bookId: book.id),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 2,
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: cover?.isNotEmpty == true
                                ? Image.network(cover!, fit: BoxFit.cover)
                                : const Center(child: Icon(Icons.book, size: 48)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 42,
                              child: Center(
                                child: Text(
                                  book.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.lato(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
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
        if (widget.vm.loading && widget.vm.books.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (widget.vm.error != null) {
          return Center(child: Text('Error: ${widget.vm.error}'));
        }

        if (!widget.vm.showBooks) {
          return Center(
            child: Text(
              'Explore',
              style: GoogleFonts.poppins(fontSize: 20),
            ),
          );
        }

        if (widget.vm.books.isEmpty) {
          return const Center(child: Text('No books available'));
        }

        return _buildGrid(widget.vm.books);
      },
    );
  }
}

// TODO: Apagination with scroll
