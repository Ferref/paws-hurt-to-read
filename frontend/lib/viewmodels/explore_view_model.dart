import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/book.dart';
import '../services/book_service.dart';

class ExploreViewModel extends ChangeNotifier {
  final BookService _bookRepository;

  ExploreViewModel({BookService? repository}) : _bookRepository = repository ?? BookService();

  List<Book> _books = [];
  List<Book> get books => _books;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  bool _showBooks = true;
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
      final fetched = await _bookRepository.fetchRange(start: start, end: end);
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
