import 'package:flutter/material.dart';
import 'package:login_signin/core/app_Validator.dart';
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
  bool _stayLoggedIn = false;

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
                "login success \nE_mail is $_email\nPassword is $_password\nStay logged in : $_stayLoggedIn",
              ); //Debug
              AppRouter.push(context, Routes.home);
            },
            children: [
              AppTextField(
                validator: Appvalidator.EmailValidator,
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
              Row(
                children: [
                  Checkbox(
                    value: _stayLoggedIn,
                    onChanged: (v) {
                      setState(() {
                        _stayLoggedIn = !_stayLoggedIn;
                      });
                    },
                  ),
                  Text("Stay Logged in"),
                ],
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
