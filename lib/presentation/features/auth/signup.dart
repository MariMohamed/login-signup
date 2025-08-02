import 'package:flutter/material.dart';
import 'package:login_signin/core/animation/vertical_animation.dart';
import 'package:login_signin/core/validator/app_Validator.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/data/user_model.dart';
import 'package:login_signin/core/validator/app_validator_types/confirmpassword_validator.dart';
import 'package:login_signin/core/validator/app_validator_types/email_validator.dart';
import 'package:login_signin/core/validator/app_validator_types/password_validator.dart';
import 'package:login_signin/core/validator/app_validator_types/phoneNumber_validator.dart';
import 'package:login_signin/presentation/features/auth/login.dart';
import 'package:login_signin/presentation/features/userlist/controller/uselist_controller.dart';
import 'package:login_signin/presentation/widget/app_center.dart';
import 'package:login_signin/presentation/widget/app_pagetitle.dart';
import 'package:login_signin/presentation/widget/app_textfield.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:login_signin/presentation/widget/formTemp.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  List<User> users = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final userResults = await userListController.getUsers();

    setState(() {
      users = userResults;
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool get isFormValid =>
      emailValidator.isValid &&
      passwordValidator.isValid &&
      confirmPasswordValidator.isValid;

  final emailValidator = EmailAppValidator();
  final passwordValidator = PasswordAppValidator();
  final confirmPasswordValidator = ConfirmPasswordAppValidator();
  final PhoneAppValidator phoneAppValidator = PhoneAppValidator();
  late String _firstName;
  late String _lastName;
  late String _userName;
  late String _password;
  late String _email;
  late String _phoneNumber;
  final UserListController userListController = UserListController();
  bool _isPasswordHidden = true;
  bool _confirmisPasswordHidden = true;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: AppCenter(
        children: [
          AppPagetitle(title: AppStrings.signup),
          FormTemplate(
            enabled: isFormValid,
            submitMessage: AppStrings.signup,
            onSubmit: () {
              final _user = User(
                id: users.length + 1,
                username: _userName,
                password: _password,
                email: _email,
                name: {'firstname': _firstName, 'lastname': _lastName},
                phone: _phoneNumber,
              );
              userListController.signup(_user, context);
            },
            children: [
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextField(
                    controller: TextEditingController(),
                    onChange: (v) {},
                    width: 200,
                    hint: AppStrings.firstName,
                    onSaved: (value) => _firstName = value!,
                  ),
                  AppTextField(
                    controller: TextEditingController(),
                    onChange: (v) {},
                    width: 200,
                    hint: AppStrings.lastName,
                    onSaved: (value) => _lastName = value!,
                  ),
                ],
              ),
              AppTextField(
                controller: TextEditingController(),
                onChange: (v) {},
                hint: AppStrings.username,
                onSaved: (value) => _userName = value!,
              ),
              AppTextField(
                controller: _emailController,
                validator: emailValidator,
                onChange: (v) {
                  setState(() {
                    emailValidator.setValue(v);
                  });
                },
                onSaved: (value) {
                  _email = value!;
                },
                hint: AppStrings.emailAddress,
                keyboardType: TextInputType.emailAddress,
                prefixIcon: Icon(Icons.email_rounded),
              ),
              AppTextField(
                validator: passwordValidator,
                onChange: (v) {
                  setState(() {
                    passwordValidator.setValue(v);
                  });
                },
                obscureText: _isPasswordHidden,
                hint: AppStrings.password,
                prefixIcon: Icon(Icons.lock_person_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
                onSaved: (value) {
                  _password = value!;
                },
                controller: _passwordController,
              ),
              AppTextField(
                validator: confirmPasswordValidator,
                onChange: (v) {
                  setState(() {
                    confirmPasswordValidator.setValue(v!);
                  });
                },
                obscureText: _confirmisPasswordHidden,
                hint: AppStrings.confirmPassword,
                controller: _confirmPasswordController,
                prefixIcon: Icon(Icons.lock_person_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmisPasswordHidden = !_confirmisPasswordHidden;
                    });
                  },
                ),

                onSaved: (value) {},
              ),
              AppTextField(
                controller: TextEditingController(),
                validator: phoneAppValidator,
                onChange: (v) {
                  setState(() {
                    phoneAppValidator.setValue(v!);
                    _focusNode.requestFocus();
                  });
                },
                hint: AppStrings.phoneNumber,
                onSaved: (v) => _phoneNumber = v!,
                prefixIcon: Icon(Icons.phone_android_rounded),
                keyboardType: TextInputType.phone,
              ), //Uses international format +1XXXXXXXXXX
            ],
          ),
          TextButton(
            onPressed: () => AppRouter.transition(
              context,
              VerticalAnimation(child: LogIn()),
            ),
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
