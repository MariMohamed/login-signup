import 'package:flutter/material.dart';
import 'package:login_signin/core/app_Validator.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/presentation/widget/app_textfield.dart';
import 'package:login_signin/presentation/widget/formTemp.dart';
import 'package:login_signin/presentation/widget/password_textfield.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _firstName;

  String? _lastName;

  String? _password;

  String? _confirmPassword;

  String? _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              FormTemplate(
                submitMessage: AppStrings.signup,
                onSubmit: () {
                  print(
                    "signup success\nAccount information :\nE_mail is $_email\nPassword is $_password",
                  ); //Debug
                  AppRouter.push(context, Routes.logIn);
                },
                children: [
                  Row(
                    spacing: 5,
                    children: [
                      AppTextField(
                        width: 200,
                        hint: AppStrings.firstName,
                        onSaved: (value) => _firstName = value,
                        validator: Appvalidator.defaultRequiredValidator,
                      ),
                      AppTextField(
                        width: 200,
                        hint: AppStrings.lastName,
                        onSaved: (value) => _lastName = value,
                        validator: Appvalidator.defaultRequiredValidator,
                      ),
                    ],
                  ),
                  AppTextField(
                    autoValidate: AutovalidateMode.onUnfocus,
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
                    passwordController: _passwordController,
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  PasswordTextfield(
                    text: AppStrings.confirmPassword,
                    passwordController: _confirmPasswordController,
                    optionalValidation: (value) {
                      if (value != _passwordController.text) {
                        return 'Passwords must match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
              TextButton(
                onPressed: () => AppRouter.push(context, Routes.logIn),
                child: InkWell(
                  hoverColor: AppColors.grey,
                  child: Text(AppStrings.backToLogIn),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
