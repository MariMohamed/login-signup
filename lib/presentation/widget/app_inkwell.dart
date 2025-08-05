import 'package:flutter/material.dart';
import 'package:login_signin/core/animation/vertical_animation.dart';
import 'package:login_signin/core/app_router.dart';

class AppInkwell extends StatelessWidget {
  const AppInkwell({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, bottom: 5),
        child: Row(
          spacing: 50,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor, size: 30),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
