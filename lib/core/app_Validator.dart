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
}
