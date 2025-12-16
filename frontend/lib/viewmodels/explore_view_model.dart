import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:frontend/models/book.dart';
import 'package:frontend/services/book_service.dart';

class ExploreViewModel extends ChangeNotifier {
  final BookService _bookService;

  List<Book> _books = [];
  bool _loading = false;
  String? _error;
  bool _showBooks = true;
  
  ExploreViewModel(this._bookService);

  List<Book> get books => _books;
  bool get loading => _loading;
  String? get error => _error;
  bool get showBooks => _showBooks;

  void hideBooks() {
    setShowBooks(false);
  }

  void setShowBooks(bool value) {
    if (_showBooks != value) {
      _showBooks = value;
      notifyListeners();
    }
  }

  Future<void> loadBooks({bool force = false}) async {
    if (!force && _books.isNotEmpty) {
      return;
    }

    final start = int.parse(dotenv.env['BOOK_RANGE_START']!);
    final end = int.parse(dotenv.env['BOOK_RANGE_END']!);

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final fetched = await _bookService.fetchRange(start: start, end: end);
      _books = fetched;
    } catch (e) {
      _error = e.toString();
      _books = [];
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> ensureLoaded() => loadBooks(force: false);
  Future<void> reload() => loadBooks(force: true);
}
