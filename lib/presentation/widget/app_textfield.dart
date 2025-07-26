import 'package:flutter/material.dart';
import 'package:login_signin/core/app_Validator.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.onSaved,
    this.validator,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.style,
    this.keyboardType,
    this.isReadOnly,
    this.obscureText,
    this.width,
    this.height,
    this.autoValidate,
    this.controller,
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
  final AutovalidateMode? autoValidate;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      width: width ?? double.infinity,
      child: TextFormField(
        textAlign: TextAlign.left,
        controller: controller,
        onSaved: onSaved,
        autovalidateMode: autoValidate,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
        validator: validator ?? Appvalidator.defaultRequiredValidator,
        //
        style: style ?? TextStyle(fontSize: 14),
        keyboardType: keyboardType ?? TextInputType.text,
        readOnly: isReadOnly ?? false,
        obscureText: obscureText ?? false,
      ),
    );
  }
}
