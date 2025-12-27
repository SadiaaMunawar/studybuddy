import 'package:flutter/material.dart';

class AppUser {
  final String name;
  final String email;

  AppUser({required this.name, required this.email});
}

class UserProvider with ChangeNotifier {
  AppUser? _currentUser;

  AppUser? get currentUser => _currentUser;

  void login(String name, String email) {
    _currentUser = AppUser(name: name, email: email);
    notifyListeners();
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
