import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordTextfield extends StatefulWidget {
  const PasswordTextfield({
    super.key,
    required this.text,
    this.onSaved,
    this.passwordController,
    this.optionalValidation,
    this.onChanged,
  });
  final String text;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final TextEditingController? passwordController;
  final Function(String?)? optionalValidation;
  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool _isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      maxLength: 20,
      obscureText: _isPasswordHidden,
      keyboardType: TextInputType.visiblePassword,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (v) {
        if (v == null || v.isEmpty) {
          return 'You must enter a Password';
        } else if (v.length < 6) {
          return 'Password must be at least 6 characters';
        }
        if (widget.optionalValidation != null) {
          return widget.optionalValidation!(v);
        }
        return null;
      },
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        hintText: widget.text,
        prefixIcon: Icon(Icons.lock_person_rounded),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            setState(() {
              _isPasswordHidden = !_isPasswordHidden;
            });
          },
        ),
      ),
      onSaved: widget.onSaved,
    );
  }
}
