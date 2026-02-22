import 'package:flutter/material.dart';

enum ThemeColor {
  blue(color: Color.fromARGB(255, 34, 118, 229)),
  green(color: Color.fromARGB(255, 229, 158, 221)),
  pink(color: Color.fromARGB(255, 156, 202, 8));

  const ThemeColor({required this.color});

  final Color color;
  Color get backgroundColor => color.withAlpha(100);
}

class ThemeColorService extends ChangeNotifier {
  ThemeColor _current = ThemeColor.green;

  ThemeColor get current => _current;
  Color get color => _current.color;
  Color get backgroundColor => _current.backgroundColor;

  void setTheme(ThemeColor theme) {
    if (_current == theme) return;
    _current = theme;
    notifyListeners();
  }
}

final themeColorService = ThemeColorService();
