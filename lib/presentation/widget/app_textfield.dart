import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.onSaved,
    required this.validator,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.style,
    this.keyboardType,
    this.isReadOnly,
    this.obscureText,
    this.width,
    this.height,
  });
  final Function(String?) onSaved;
  final FormFieldValidator<String>? validator;
  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final bool? isReadOnly;
  final bool? obscureText;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: TextFormField(
        onSaved: onSaved,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        validator: validator,
        //
        style: style ?? TextStyle(fontSize: 14, color: AppColors.black),
        keyboardType: keyboardType ?? TextInputType.text,
        readOnly: isReadOnly ?? false,
        obscureText: obscureText ?? false,
      ),
    );
  }
}
