import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_signin/core/app_colors.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });
  final String icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(60)),
          color: AppColors.transperntGrey,
          boxShadow: [
            BoxShadow(
              color: AppColors.transperntGrey,
              offset: Offset(0, 0), // X: 0, Y: 0
              blurRadius: 11.25, // Blur: 11.25
              spreadRadius: 0,
            ),
          ],
        ),
        child: SvgPicture.asset(
          icon,
          width: 18,
          height: 18,

          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
