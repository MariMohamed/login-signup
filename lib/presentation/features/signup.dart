import 'package:flutter/material.dart';
import 'package:login_signin/core/app_Validator.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/presentation/widget/app_center.dart';
import 'package:login_signin/presentation/widget/app_pagetitle.dart';
import 'package:login_signin/presentation/widget/app_textfield.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:login_signin/presentation/widget/dropDown.dart';
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
  String? _email;
  String? _gender;
  String? _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: AppCenter(
        children: [
          AppPagetitle(title: AppStrings.signup),
          FormTemplate(
            submitMessage: AppStrings.signup,
            onSubmit: () {
              print(
                "signup success\nAccount information :\nFirst name : $_firstName\nLast name: $_lastName\nE_mail : $_email\nPassword : $_password \nGender: $_gender\nPhone number: $_phoneNumber",
              ); //Debug
              AppRouter.push(context, Routes.logIn);
            },
            children: [
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextField(
                    width: 200,
                    hint: AppStrings.firstName,
                    onSaved: (value) => _firstName = value,
                  ),
                  AppTextField(
                    width: 200,
                    hint: AppStrings.lastName,
                    onSaved: (value) => _lastName = value,
                  ),
                ],
              ),
              AppTextField(
                autoValidate: AutovalidateMode.onUnfocus,
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
                passwordController: _passwordController,
                optionalValidation: (v) {
                  if (v!.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                },
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
              AppDropDownMenu(
                icon: Icon(Icons.person),
                dropDownItems: ["Male", "Female"],
                title: "Gender",
                onSaved: (v) => _gender = v,
              ),
              AppTextField(
                autoValidate: AutovalidateMode.onUnfocus,
                hint: AppStrings.phoneNumber,
                onSaved: (v) => _phoneNumber = v,
                prefixIcon: Icon(Icons.phone_android_rounded),
                keyboardType: TextInputType.phone,
                validator: Appvalidator.phoneNumberValidator,
              ), //Uses international format +1XXXXXXXXXX
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
    );
  }
}
