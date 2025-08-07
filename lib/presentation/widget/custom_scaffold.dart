import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/providers/app_themeSwitcher.dart';
import 'package:provider/provider.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.drawer,
    this.navBar,
    this.appBar,
  });
  final Widget body;
  final Widget? drawer;
  final Widget? navBar;
  final PreferredSizeWidget? appBar;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: drawer,
      bottomNavigationBar: navBar,
      appBar: appBar,
      body: body,
    );
  }
}
