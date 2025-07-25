import 'package:flutter/material.dart';

class Standardcontainer extends StatelessWidget {
  const Standardcontainer({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 70,
      padding: EdgeInsets.only(top: 5, bottom: 5, left: 3, right: 3),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Color.fromARGB(255, 226, 226, 226)),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: child ?? Container(),
    );
  }
}
