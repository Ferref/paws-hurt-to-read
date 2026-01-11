import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

import 'package:frontend/services/auth_service.dart';

import 'package:frontend/models/user_book.dart';

class MyBooksViewModel extends ChangeNotifier {
  List<UserBook> books = [];
  bool isLoading = false;
  Object? error;
  final AuthService _authService = getIt<AuthService>();

  Future<void> loadBooks() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      books = (await _authService.getBooks());
    } catch (e) {
      error = e;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}