import 'package:flutter/foundation.dart';
import '../models/book.dart';
import '../repositories/book_repository.dart';

class HomeViewModel extends ChangeNotifier {
  final BookRepository _bookRepository;

  HomeViewModel({BookRepository? repository}) : _bookRepository = repository ?? BookRepository();

  List<Book> _books = [];
  List<Book> get books => _books;

  bool _loading = false;
  bool get loading => _loading;

  String? _error;
  String? get error => _error;

  Future<void> loadBooks({int start = 1, int end = 10}) async {
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
}
