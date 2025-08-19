import 'package:flutter/material.dart';
import 'package:login_signin/core/firebase/auth.dart';
import 'package:login_signin/presentation/features/Home/view/homescreen.dart';
import 'package:login_signin/presentation/features/auth/login.dart';

class Warpper extends StatelessWidget {
  Warpper({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    //return _auth.isLoggedIn ? HomeScreen() : LogIn();
    return StreamBuilder(
      stream: _auth.authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(child: CircularProgressIndicator());
        } else if (snapshot.data != null) {
          return HomeScreen();
        }
        return LogIn();
      },
    );
  }
}
