import 'package:flutter/material.dart';
import 'package:login_signin/presentation/widget/app_center.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: AppCenter(
        children: [
          AppButton(
            title: AppStrings.logOut,
            onPressed: () {
              AppRouter.push(context, Routes.logIn);
            },
          ),
        ],
      ),
    );
  }
}
