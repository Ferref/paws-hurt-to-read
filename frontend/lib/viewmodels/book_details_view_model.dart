import 'package:flutter/foundation.dart';

import 'package:frontend/models/book_details.dart';
import 'package:frontend/services/book_service.dart';
import 'package:frontend/services/auth_service.dart';

class BookDetailsViewModel extends ChangeNotifier {
  final BookService _bookService;
  final AuthService _authService;

  BookDetails? _bookDetails;
  bool _isLoading = false;
  String? _errorMessage;

  BookDetailsViewModel(this._bookService, this._authService);

  BookDetails? get bookDetails => _bookDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBookDetails(String bookId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final details = await _bookService.fetchBookDetails(bookId);
      _bookDetails = details;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> storeBook(int bookId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.storeBook(bookId: bookId);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    return true;
  }
}
