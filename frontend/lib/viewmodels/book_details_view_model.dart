import 'package:flutter/foundation.dart';
import '../models/book_details.dart';
import '../repositories/book_repository.dart';

class BookDetailsViewModel extends ChangeNotifier
{
  final BookRepository _bookRepository = BookRepository();
  BookDetails? _bookDetails;
  bool _isLoading = false;
  String? _errorMessage;

  BookDetails? get bookDetails => _bookDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBookDetails(String bookId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final details = await _bookRepository.fetchBookDetails(bookId);
      _bookDetails = details;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
  

