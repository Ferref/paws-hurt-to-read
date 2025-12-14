
import 'package:flutter/foundation.dart';
import 'package:frontend/services/registration_service.dart';
import '../models/user.dart';

class RegistrationViewModel extends ChangeNotifier {
  final RegistrationService _registrationService = RegistrationService();
  User? _user;
  bool _loading = false;

  User? get user => _user;
  bool get loading => _loading;

  Future<User?> store(String name, String email, String password, String passwordConfirmation) async {
    _loading = true;
    notifyListeners();
    
    _user = await _registrationService.store(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    
    _loading = false;
    notifyListeners();
  }
}