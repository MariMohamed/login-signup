import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/validator/app_Validator.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.onChange,
    required this.onSaved,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    this.style,
    this.keyboardType,
    this.isReadOnly,
    this.obscureText,
    this.width,
    this.height,
    this.validator,
    this.inputFormatters,
  });
  final TextEditingController controller;
  final Function(String)? onChange;
  final Function(String?) onSaved;

  final String? hint;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final bool? isReadOnly;
  final bool? obscureText;
  final double? width;
  final double? height;
  final AppValidator? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: widget.height ?? 50,
          width: widget.width ?? double.infinity,
          child: TextFormField(
            controller: widget.controller,
            //
            onChanged: widget.onChange,
            onSaved: widget.onSaved,
            //
            inputFormatters: widget.inputFormatters,
            decoration: InputDecoration(
              hintText: widget.hint,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
            ),

            //
            style:
                widget.style ?? TextStyle(fontSize: 14, color: AppColors.black),
            keyboardType: widget.keyboardType ?? TextInputType.text,
            readOnly: widget.isReadOnly ?? false,
            obscureText: widget.obscureText ?? false,
          ),
        ),
        if (widget.validator != null) getValidationHints(),
      ],
    );
  }

  Widget getValidationHints() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ...widget.validator!.reasons.map(
          (e) => Column(
            children: [
              const SizedBox(height: 5),
              Text(e, style: TextStyle(color: AppColors.red, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
