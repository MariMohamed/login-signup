import 'package:flutter/material.dart';
import 'package:login_signin/main.dart';
import 'package:provider/provider.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class AppThemeSwitch extends StatelessWidget {
  const AppThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Switch(
      value: themeProvider.isDarkMode,
      onChanged: (value) {
        themeProvider.setTheme(value ? ThemeMode.dark : ThemeMode.light);
      },
    );
  }
}
