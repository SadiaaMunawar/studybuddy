import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  MaterialColor _primaryColor = Colors.pink; // default

  ThemeMode get mode => _mode;
  MaterialColor get primaryColor => _primaryColor;

  void setMode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void setColor(String colorName) {
    switch (colorName) {
      case 'Blue':
        _primaryColor = Colors.blue;
        break;
      case 'Purple':
        _primaryColor = Colors.purple;
        break;
      case 'Green':
        _primaryColor = Colors.green;
        break;
      case 'Orange':
        _primaryColor = Colors.orange;
        break;
      case 'Pink':
        _primaryColor = Colors.pink;
        break;
      default:
        _primaryColor = Colors.blue;
    }
    notifyListeners();
  }
}
