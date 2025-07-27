import 'package:flutter/material.dart';

class Routes {
  static String signUp = '/Sign Up';
  static String logIn = '/login';
  static String home = '/home';
}

class AppRouter {
  static Future push(BuildContext appContext, String name) =>
      Navigator.pushNamed(appContext, name);

  static Future pushArgument(
    BuildContext appContext,
    String name,
    Object argument,
  ) => Navigator.pushNamed(appContext, name, arguments: argument);
}
