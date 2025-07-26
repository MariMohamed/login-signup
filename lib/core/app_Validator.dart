import 'package:flutter/material.dart';

class Appvalidator {
  static FormFieldValidator<String>? defaultRequiredValidator = (value) {
    if (value == null || value.isEmpty) {
      return "Field can't be empty";
    }
    return null; // Return null means valid
  };
  static FormFieldValidator<String>? defaultUnrequiredValidator = (value) {
    return null; // Return null means valid
  };
  static FormFieldValidator<String> EmailValidator = (value) {
    if (value!.isEmpty ||
        !RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(value)) {
      return 'Enter a valid email!';
    }
    return null;
  };
  static FormFieldValidator<String> phoneNumberValidator = (value) {
    String patttern = r'^\+(?:[0-9] ?){6,14}[0-9]$';
    RegExp regExp = new RegExp(patttern);
    if (value == null || value.isEmpty) {
      return 'Please enter mobile number';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter valid mobile number';
    }
    return null;
  };
}
