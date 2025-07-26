// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:login_signin/core/app_Validator.dart';

class AppDropDownMenu extends StatelessWidget {
  const AppDropDownMenu({
    super.key,
    required this.dropDownItems,
    required this.title,
    required this.onSaved,
    this.validator,
    this.icon,
  });
  final List<String> dropDownItems;
  final String title;
  final Function(String?) onSaved;
  final FormFieldValidator<String>? validator;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: dropDownItems.map((p) {
        return DropdownMenuItem(value: p, child: Text(p));
      }).toList(),
      decoration: InputDecoration(label: Text(title), prefixIcon: icon),
      onChanged: (value) {},
      validator: validator ?? Appvalidator.defaultRequiredValidator,
      onSaved: onSaved,
    );
  }
}
