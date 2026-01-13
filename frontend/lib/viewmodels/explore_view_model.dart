import 'package:flutter/foundation.dart';
import 'package:frontend/models/book.dart';
import 'package:frontend/services/book_service.dart';

class ExploreViewModel extends ChangeNotifier {
  final BookService _bookService;

  ExploreViewModel(this._bookService);

  final List<Book> _books = [];
  bool _loading = false;
  bool _hasMore = true;
  int _page = 0;
  final int _limit = 25;
  String? _error;
  bool _showBooks = true;

  List<Book> get books => _books;
  bool get loading => _loading;
  String? get error => _error;
  bool get showBooks => _showBooks;

  void hideBooks() => setShowBooks(false);

  void setShowBooks(bool value) {
    if (_showBooks != value) {
      _showBooks = value;
      notifyListeners();
    }
  }

  Future<void> loadNext() async {
    if (_loading || !_hasMore) return;

    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final start = _page * _limit;
      final end = start + _limit;
      final fetched =
          await _bookService.fetchRange(start: start, end: end);

      if (fetched.length < _limit) {
        _hasMore = false;
      }

      _books.addAll(fetched);
      _page++;
    } catch (e) {
      _error = e.toString();
      _hasMore = false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> ensureLoaded() async {
    if (_books.isEmpty) {
      await loadNext();
    }
  }
}