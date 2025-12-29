import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ local storage
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  User? _user;

  AuthProvider() {
    // Listen to auth state changes
    AuthService.authState.listen((u) async {
      _user = u;
      if (_user != null) {
        // ✅ Save UID/email locally
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('uid', _user!.uid);
        await prefs.setString('email', _user!.email ?? '');
      }
      notifyListeners();
    });
  }

  User? get currentUser => _user;
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

    // ✅ Clear local storage
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('uid');
    await prefs.remove('email');

    notifyListeners();
  }

  // ✅ Restore user info from local storage (e.g., in SplashScreen)
  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('uid');
    final email = prefs.getString('email');

    if (uid != null) {
      // Only sets cached info — Firebase will still verify session
      _user = FirebaseAuth.instance.currentUser;
      notifyListeners();
    }
  }
}
