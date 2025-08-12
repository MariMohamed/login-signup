import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onPressed,
    this.prefix,
    this.title = '',
    this.style,
    this.backgroundColor,
    this.width = 100,
    this.height,
    this.suffix,
  });
  final VoidCallback onPressed;
  final Widget? prefix;
  final Widget? suffix;
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            prefix ?? SizedBox(width: 1),
            Text(
              title!,
              //
              style: style,

              //
            ),
            suffix ?? SizedBox(width: 1),
          ],
        ),
      ),
    );
  }
}
