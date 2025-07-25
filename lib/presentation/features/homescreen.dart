import 'package:flutter/material.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppButton(
          title: AppStrings.login,
          onPressed: () {
            AppRouter.push(context, Routes.logIn);
          },
        ),
      ),
    );
  }
}
