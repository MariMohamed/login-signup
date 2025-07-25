// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DropDownMenu extends StatefulWidget {
  DropDownMenu({
    super.key,
    required this.dropDownItems,
    required this.title,
    required this.onSaved,
    required this.errorMessage,
  });
  final List<String> dropDownItems;
  final String title;
  final Function(String?) onSaved;
  final String errorMessage;

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: widget.dropDownItems.map((p) {
        return DropdownMenuItem(value: p, child: Text(p));
      }).toList(),
      decoration: InputDecoration(label: Text(widget.title)),
      onChanged: (value) {},
      validator: (v) {
        if (v == null || v.isEmpty) {
          return widget.errorMessage;
        }
        return null;
      },
      onSaved: widget.onSaved,
    );
  }
}
