import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
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

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map?;
      if (args?["showToast"] == true) {
        DelightToastBar(
          snackbarDuration: Durations.short2,
          animationDuration: Durations.short1,
          position: DelightSnackbarPosition.top,
          builder: (context) => const ToastCard(
            leading: Icon(Icons.circle_notifications_rounded, size: 28),
            title: Text(
              "Logged out successfully",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
            ),
          ),
        ).show(context);
        Future.delayed(Duration(seconds: 2), () => DelightToastBar.removeAll());
      }
    });
  }

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
                controller: _emailController,
                validator: Appvalidator.EmailValidator,
                onSaved: (value) {
                  _email = _emailController.text;
                },
                hint: AppStrings.emailAddress,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email_rounded),
              ),
              PasswordTextfield(
                passwordController: _passwordController,
                text: AppStrings.password,
                onSaved: (value) {
                  _password = _passwordController.text;
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
