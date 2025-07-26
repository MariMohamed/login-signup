import 'package:flutter/material.dart';
import 'package:login_signin/presentation/widget/app_themeSwitch.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [AppThemeSwitch()],
        automaticallyImplyLeading: false,
      ),
      body: body,
    );
  }
}
