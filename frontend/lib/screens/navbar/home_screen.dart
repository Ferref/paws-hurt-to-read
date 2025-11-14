import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../viewmodels/home_view_model.dart';
import '../../models/book.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _vm = HomeViewModel();

  @override
  void initState() {
    super.initState();
    // load initial range
    _vm.loadBooks(start: 1, end: 10);
  }

  @override
  void dispose() {
    _vm.dispose();
    super.dispose();
  }

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
          onTap: () {},
          child: Card(
            color: Colors.white70,
            elevation: 2,
            clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: cover.isNotEmpty
                      ? Image.network(
                          cover,
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
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _vm,
      builder: (context, _) {
        if (_vm.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_vm.error != null) {
          return Center(child: Text('Error: ${_vm.error}'));
        }

        final books = _vm.books;
        if (books.isEmpty) {
          return const Center(child: Text('No books available'));
        }

        return _buildGrid(books);
      },
    );
  }
}