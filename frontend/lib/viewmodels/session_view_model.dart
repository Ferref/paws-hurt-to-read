import 'package:flutter/foundation.dart';
import 'package:frontend/services/session_service.dart';
import '../models/user.dart';

class SessionViewModel extends ChangeNotifier {
  final SessionService _sessionService = SessionService();
  User? _user;
  bool _loading = false;

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