import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/core/animation/vertical_animation.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/firebase/auth.dart';
import 'package:login_signin/core/manager/shared_preferences_manager.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      //await _checkAutoLogin();
      await _handleLogout();
    });
  }

  Future<void> _handleLogout() async {
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
  }

  // Future<void> _checkAutoLogin() async {
  //   try {
  //     final appData = Provider.of<AppDataProvider>(context, listen: false);
  //     while (appData.isLoading) {
  //       await Future.delayed(const Duration(milliseconds: 1));
  //       if (!mounted) return;
  //     }
  //     // Check if we should attempt auto-login
  //     final shouldSkipLogin = await appData.initializeUserFromToken(context);

  //     if (shouldSkipLogin && mounted) {
  //       // If auto-login successful, show brief feedback
  //       DelightToastBar(
  //         snackbarDuration: Durations.short2,
  //         animationDuration: Durations.short1,
  //         builder: (context) => const ToastCard(
  //           leading: Icon(Icons.check_circle, size: 28, color: Colors.green),
  //           title: Text(
  //             "Auto login successful",
  //             style: TextStyle(fontWeight: FontWeight.w500),
  //           ),
  //         ),
  //       ).show(context);
  //       Future.delayed(Duration(seconds: 2), () => DelightToastBar.removeAll());
  //     }
  //   } catch (e) {
  //     if (mounted) {
  //       // Show error if auto-login fails
  //       DelightToastBar(
  //         snackbarDuration: Durations.short2,
  //         animationDuration: Durations.short1,
  //         builder: (context) => ToastCard(
  //           leading: Icon(Icons.error_outline, size: 28, color: Colors.orange),
  //           title: Text("Please login again"),
  //         ),
  //       ).show(context);
  //       Future.delayed(Duration(seconds: 2), () => DelightToastBar.removeAll());
  //     }
  //   }
  // }
  final AuthService _auth = AuthService();
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
                    // await Provider.of<AppDataProvider>(
                    //   context,
                    //   listen: false,
                    // ).login(_username, _password, context);
                    await _auth.login(_username, _password, context);
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
                IconButton(
                  onPressed: () async {
                    dynamic result = await _auth.signInAnon();
                    if (result == null) {
                      print("no user");
                    } else {
                      print(result);
                    }
                  },
                  icon: Icon(Icons.person),
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
