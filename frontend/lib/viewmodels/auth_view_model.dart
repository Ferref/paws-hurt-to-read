import 'package:flutter/foundation.dart';

import 'package:frontend/models/user.dart';
import 'package:frontend/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  User? _user;
  bool _loading = false;

  AuthViewModel(this._authService);

  User? get user => _user;
  bool get loading => _loading;

  Future<User?> store(String name, String password) async {
    _loading = true;
    notifyListeners();

    _user = await _authService.store(
      name: name,
      password: password,
    );

    _loading = false;
    notifyListeners();

    return _user;
  }

  Future<void> destroy() async {
    _loading = true;
    notifyListeners();

    await _authService.destroy();
    _user = null;

    _loading = false;
    notifyListeners();
  }

  Future<void> storeBook({required int bookId}) async {
    _loading = true;
    notifyListeners();

    await _authService.storeBook(bookId: bookId);

    _loading = false;
    notifyListeners();
  }
}