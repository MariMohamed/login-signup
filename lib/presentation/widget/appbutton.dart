import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.child,
    this.title = '',
    this.style,
    this.backgroundColor,
    this.width = 100,
    this.height,
  });
  final VoidCallback onPressed;
  final Widget? child;
  final String? title;
  final TextStyle? style;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            backgroundColor ?? Theme.of(context).colorScheme.primary,
          ),
          foregroundColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        onPressed: onPressed,
        child:
            child ??
            Text(
              title!,
              //
              style: style,

              //
            ),
      ),
    );
  }
}
