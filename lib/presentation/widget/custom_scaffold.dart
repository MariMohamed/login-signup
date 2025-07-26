import 'package:flutter/material.dart';
import 'package:login_signin/core/manager/app_themeSwitcher.dart';
import 'package:provider/provider.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.setTheme(value ? ThemeMode.dark : ThemeMode.light);
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: body,
    );
  }
}
