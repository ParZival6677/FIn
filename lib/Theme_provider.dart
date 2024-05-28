import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF1E1E1E),
    colorScheme: ColorScheme.dark(),
    primaryColor: Color(0xFF2C3E50),
    iconTheme: IconThemeData(color: Colors.white),
    cardColor: Color(0xFF374151),
    dividerColor: Colors.grey[600],
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF374151),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    primaryColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    cardColor: Colors.white,
    dividerColor: Colors.grey[300],
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
    ),
  );
}
