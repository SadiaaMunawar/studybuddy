class Validators {
  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'Enter a valid email';
  }

  static String? password(String? v) {
    if (v == null || v.trim().isEmpty) return 'Password is required';
    if (v.trim().length < 6) return 'Minimum 6 characters';
    return null;
  }

  static String? nonEmpty(String? v, {String field = 'Field'}) {
    if (v == null || v.trim().isEmpty) return '$field is required';
    return null;
  }
}
