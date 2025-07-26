import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/presentation/widget/app_center.dart';
import 'package:login_signin/presentation/widget/app_pagetitle.dart';
import 'package:login_signin/presentation/widget/app_textfield.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:login_signin/presentation/widget/formTemp.dart';
import 'package:login_signin/presentation/widget/password_textfield.dart';

// ignore: must_be_immutable
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String? _password;
  String? _email;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: AppCenter(
        children: [
          AppPagetitle(title: AppStrings.login),
          FormTemplate(
            submitMessage: AppStrings.login,
            onSubmit: () {
              print(
                "login success \nE_mail is $_email\nPassword is $_password",
              ); //Debug
              AppRouter.push(context, Routes.home);
            },
            children: [
              AppTextField(
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                      ).hasMatch(value)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value;
                },
                hint: AppStrings.emailAddress,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email_rounded),
              ),
              PasswordTextfield(
                text: AppStrings.password,
                onSaved: (value) {
                  _password = value;
                },
              ),
            ],
          ),
          TextButton(
            onPressed: () => AppRouter.push(context, Routes.signUp),
            child: InkWell(
              hoverColor: AppColors.grey,
              child: Text(AppStrings.registerNewAccount),
            ),
          ),
        ],
      ),
    );
  }
}
