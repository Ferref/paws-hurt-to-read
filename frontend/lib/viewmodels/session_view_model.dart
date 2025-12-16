import 'package:flutter/foundation.dart';

import 'package:frontend/models/user.dart';
import 'package:frontend/services/session_service.dart';

// TODO: after auth load user

class SessionViewModel extends ChangeNotifier {
  final SessionService _sessionService;
  
  User? _user;
  bool _loading = false;

  SessionViewModel(this._sessionService);

  User? get user => _user;
  bool get loading => _loading;

  Future<User?> store(String name, String password) async {
    _loading = true;
    notifyListeners();
    
    _user = await _sessionService.store(
      name: name,
      password: password,
    );
    
    _loading = false;
    notifyListeners();

    return _user;
  }

  Future<void> destroy() async {
    _loading = true;
    
    _user = await _sessionService.destroy();
    notifyListeners();

    _loading = false;
  }

  Future<User?> storeBook({ required int bookId }) async {
    _loading = true;
    notifyListeners();
    
    await _sessionService.storeBook(bookId: bookId);
    
    _loading = false;
    notifyListeners();

    return _user;
  }

}