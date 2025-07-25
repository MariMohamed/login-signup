import 'package:flutter/material.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButton(
          title: AppStrings.signup,
          onPressed: () {
            AppRouter.push(context, Routes.logIn);
          },
        ),
      ),
    );
  }
}
