import 'package:flutter/material.dart';

class AppPagetitle extends StatelessWidget {
  const AppPagetitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(fontSize: 50));
  }
}
