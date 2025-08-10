import 'package:flutter/material.dart';
import 'package:login_signin/core/animation/vertical_animation.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/data/user_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/core/validator/app_validator_types/confirmpassword_validator.dart';
import 'package:login_signin/core/validator/app_validator_types/email_validator.dart';
import 'package:login_signin/core/validator/app_validator_types/name__validator.dart';
import 'package:login_signin/core/validator/app_validator_types/password_validator.dart';
import 'package:login_signin/core/validator/app_validator_types/phoneNumber_validator.dart';
import 'package:login_signin/presentation/features/auth/login.dart';
import 'package:login_signin/presentation/widget/app_center.dart';
import 'package:login_signin/presentation/widget/app_pagetitle.dart';
import 'package:login_signin/presentation/widget/app_textfield.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:login_signin/presentation/widget/formTemp.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true; // This preserves the state
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController(text: '+20');
  final _userNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // @override
  // void dispose() {
  //   _passwordController.dispose();
  //   _confirmPasswordController.dispose();
  //   _emailController.dispose();
  //   _phoneController.dispose();
  //   _firstNameController.dispose();
  //   _lastNameController.dispose();
  //   _userNameController.dispose();
  //   super.dispose();
  // }

  bool get isFormValid =>
      emailValidator.isValid &&
      passwordValidator.isValid &&
      confirmPasswordValidator.isValid &&
      firstNameValidator.isValid &&
      lastNameValidator.isValid &&
      userNameValidator.isValid &&
      phoneAppValidator.isValid;

  final emailValidator = EmailAppValidator();
  final passwordValidator = PasswordAppValidator();
  final confirmPasswordValidator = ConfirmPasswordAppValidator();
  final PhoneAppValidator phoneAppValidator = PhoneAppValidator();
  final NameValidator firstNameValidator = NameValidator();
  final NameValidator lastNameValidator = NameValidator();
  final NameValidator userNameValidator = NameValidator();
  late String _firstName;
  late String _lastName;
  late String _userName;
  late String _password;
  late String _email;
  late String _phoneNumber;
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
            onSubmit: () async {
              final user = User(
                username: _userName,
                password: _password,
                email: _email,
                name: {'firstname': _firstName, 'lastname': _lastName},
                phone: _phoneNumber,
              );

              await Provider.of<AppDataProvider>(
                context,
                listen: false,
              ).addUser(user, context);
            },
            children: [
              Row(
                spacing: 5,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTextField(
                    controller: _firstNameController,
                    onChange: (v) {
                      setState(() {
                        firstNameValidator.setValue(v);
                      });
                    },
                    width: 200,
                    hint: AppStrings.firstName,
                    validator: firstNameValidator,

                    onSaved: (value) => setState(() {
                      _firstName = _firstNameController.text;
                    }),
                  ),
                  AppTextField(
                    controller: _lastNameController,
                    onChange: (v) {
                      setState(() {
                        lastNameValidator.setValue(v);
                      });
                    },
                    validator: lastNameValidator,
                    width: 200,
                    hint: AppStrings.lastName,
                    onSaved: (value) => setState(() {
                      _lastName = _lastNameController.text;
                    }),
                  ),
                ],
              ),
              AppTextField(
                controller: _userNameController,
                onChange: (v) {
                  setState(() {
                    userNameValidator.setValue(v);
                  });
                },
                validator: userNameValidator,
                hint: AppStrings.username,
                onSaved: (value) => setState(() {
                  _userName = _userNameController.text;
                }),
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
                  confirmPasswordValidator.setValue(v);
                  confirmPasswordValidator.comparedWithPassword =
                      _passwordController.text;
                  setState(() {});
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
                controller: _phoneController,
                validator: phoneAppValidator,
                onChange: (v) {
                  setState(() {
                    phoneAppValidator.setValue(v);
                    _focusNode.requestFocus();
                  });
                },
                hint: AppStrings.phoneNumber,
                onSaved: (v) => setState(() {
                  _phoneNumber = v!;
                }),
                prefixIcon: Icon(Icons.phone_android_rounded),
                keyboardType: TextInputType.phone,
              ),
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
