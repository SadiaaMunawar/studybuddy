import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  AuthProvider() {
    // Listen to auth state changes from your AuthService
    AuthService.authState.listen((u) {
      _user = u;
      notifyListeners();
    });
  }

  /// Expose the current Firebase user
  User? get currentUser => _user;

  /// Whether a user is logged in
  bool get isLoggedIn => _user != null;

  Future<void> signInEmail(String email, String password) async {
    await AuthService.signInWithEmail(email, password);
  }

  Future<void> registerEmail(String email, String password) async {
    await AuthService.registerWithEmail(email, password);
  }

  Future<void> signInGoogle() async {
    await AuthService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await AuthService.signOut();
    _user = null;
    notifyListeners();
  }
}
