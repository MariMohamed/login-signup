import 'package:flutter/material.dart';

class AppCenter extends StatelessWidget {
  const AppCenter({super.key, required this.children});
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: children,
          ),
        ),
      ),
    );
  }
}
