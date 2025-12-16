import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:frontend/models/user.dart';
import 'package:frontend/services/session_service.dart';

class LoginViewModel extends ChangeNotifier {
  final SessionService _sessionService;
  
  User? _user;
  bool _loading = false;

  LoginViewModel(this._sessionService);

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
}