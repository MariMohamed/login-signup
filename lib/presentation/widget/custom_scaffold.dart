import 'package:flutter/material.dart';
import 'package:login_signin/core/providers/app_themeSwitcher.dart';
import 'package:provider/provider.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.drawer,
    this.implyleading,
    this.navBar,
  });
  final Widget body;
  final Widget? drawer;
  final bool? implyleading;
  final Widget? navBar;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      drawer: drawer,
      bottomNavigationBar: navBar,
      appBar: AppBar(
        actions: [
          Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.setTheme(value ? ThemeMode.dark : ThemeMode.light);
            },
          ),
        ],
        automaticallyImplyLeading: implyleading ?? false,
        notificationPredicate: (_) => false,
      ),
      body: body,
    );
  }
}
