import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordTextfield extends StatefulWidget {
  PasswordTextfield({super.key, required this.text, required this.onSaved});
  final String text;
  final Function(String?) onSaved;
  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool _isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      obscureText: _isPasswordHidden,
      keyboardType: TextInputType.visiblePassword,
      validator: (v) {
        if (v == null || v.isEmpty) {
          return 'You must enter a Password';
        } else if (v.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
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
