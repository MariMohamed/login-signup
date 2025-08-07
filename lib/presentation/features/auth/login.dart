import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/core/animation/vertical_animation.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/auth/signup.dart';
import 'package:login_signin/presentation/widget/app_center.dart';
import 'package:login_signin/presentation/widget/app_pagetitle.dart';
import 'package:login_signin/presentation/widget/app_textfield.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:login_signin/presentation/widget/formTemp.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  late String _password;
  late String _username;
  final _passwordController = TextEditingController();

  final _usernameController = TextEditingController();
  bool _isPasswordHidden = true;
  bool get isFormValid {
    return _usernameController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty;
  }

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
    final appData = Provider.of<AppDataProvider>(context);
    return appData.isLoading
        ? Center(child: CircularProgressIndicator())
        : CustomScaffold(
            body: AppCenter(
              children: [
                AppPagetitle(title: AppStrings.login),
                FormTemplate(
                  enabled: isFormValid,
                  submitMessage: AppStrings.login,
                  onSubmit: () async {
                    await Provider.of<AppDataProvider>(
                      context,
                      listen: false,
                    ).login(_username, _password, context);
                  },
                  children: [
                    AppTextField(
                      controller: _usernameController,
                      onChange: (v) {
                        setState(() {});
                      },
                      onSaved: (value) {
                        _username = _usernameController.text;
                      },
                      hint: AppStrings.username,
                      prefixIcon: Icon(Icons.person),
                    ),
                    AppTextField(
                      obscureText: _isPasswordHidden,
                      hint: AppStrings.password,
                      prefixIcon: Icon(Icons.lock_person_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordHidden
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordHidden = !_isPasswordHidden;
                          });
                        },
                      ),
                      onSaved: (value) {
                        _password = _passwordController.text;
                      },
                      controller: _passwordController,
                      onChange: (value) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => AppRouter.transition(
                    context,
                    VerticalAnimation(child: SignUp()),
                  ),
                  //AppRouter.push(context, Routes.signUp),
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
