import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/utils/formatter.dart';
import 'package:frontend/views/my_books/choice_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:frontend/main.dart';
import 'package:frontend/common/search_bar_widget.dart';
import 'package:frontend/models/user_book.dart';
import 'package:frontend/viewmodels/my_books_view_model.dart';
import 'package:frontend/views/my_books/import_widget.dart';

class MyBooksView extends StatefulWidget {
  const MyBooksView({super.key});

  @override
  State<MyBooksView> createState() => _MyBooksViewState();
}

class _MyBooksViewState extends State<MyBooksView>
    with AutomaticKeepAliveClientMixin {
  final MyBooksViewModel vm = getIt<MyBooksViewModel>();

  @override
  void initState() {
    super.initState();
    vm.loadBooks();
  }

  Future<void> _refresh() async {
    await vm.loadBooks();
  }

  @override
  bool get wantKeepAlive => true;

  Widget _buildGrid(List<UserBook> books) {
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
        final ub = books[index];
        final title = ub.book.title;
        final cover = ub.book.coverImage;

        return Card(
          color: Theme.of(context).navigationBarTheme.backgroundColor,
          elevation: 2,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () async {
              final isChange =
                  await Navigator.push<bool>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChoiceWidget(
                        title: "Manage your book",
                        message: Formatter.truncateText(
                          books[index].book.title,
                          60,
                        ),
                        bookId: books[index].book.id,
                      ),
                    ),
                  ) ??
                  false;

              if (isChange) {
                _refresh();
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: (cover != null && cover.isNotEmpty)
                      ? Image.network(
                          cover,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Center(child: Icon(Icons.broken_image)),
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) {
                              return child;
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        )
                      : Center(
                          child: Icon(
                            Icons.book,
                            size: 40,
                            color: Theme.of(context).iconTheme.color,
                          ),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 42,
                    child: Center(
                      child: Text(
                        title,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
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
  Widget build(BuildContext context) {
    super.build(context);
    final background = Theme.of(context).appBarTheme.backgroundColor;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            const SearchBarWidget(),
            Expanded(
              child: ListenableBuilder(
                listenable: vm,
                builder: (context, _) {
                  if (vm.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (vm.error != null) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(FontAwesomeIcons.searchengin, size: 100),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(vm.error.toString().replaceAll("Exception: ", ""), style: GoogleFonts.poppins(fontSize: 24)),
                        ),
                        ElevatedButton(
                          onPressed: _refresh,
                          child: const Text('Retry'),
                        ),
                      ],
                    );
                  }

                  if (vm.books.isEmpty) {
                    return const Center(child: Text('No books found'));
                  }

                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: _buildGrid(vm.books),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // TODO: after importing/adding, call _refresh()
            const ImportWidget(),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
