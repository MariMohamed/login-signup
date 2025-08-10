import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/app_textStyles.dart';
import 'package:login_signin/core/data/user_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/core/validator/app_validator_types/confirmpassword_validator.dart';
import 'package:login_signin/core/validator/app_validator_types/email_validator.dart';
import 'package:login_signin/core/validator/app_validator_types/name__validator.dart';
import 'package:login_signin/core/validator/app_validator_types/password_validator.dart';
import 'package:login_signin/core/validator/app_validator_types/phoneNumber_validator.dart';
import 'package:login_signin/presentation/features/Home/widgets/home_useravatar.dart';
import 'package:login_signin/presentation/features/productlist/view/add_product.dart';
import 'package:login_signin/presentation/widget/app_textfield.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:login_signin/presentation/widget/formTemp.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _userNameController = TextEditingController();

  final NameValidator userNameValidator = NameValidator();

  late String _userName;

  bool _isreadOnly = true;

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context);
    return CustomScaffold(
      appBar: AppBar(
        title: Text(AppStrings.profile),
        leading: IconButton(
          icon: SvgPicture.asset(AppAssets.backarrow), // Custom back icon
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _isreadOnly = !_isreadOnly;
              });
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Useravatar(),
              _isreadOnly
                  ? Text(
                      appData.currentUser!.username,
                      style: TextStyles.w600s16Style,
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppTextField(
                          width: 100,
                          controller: _userNameController,
                          onChange: (v) {
                            setState(() {
                              userNameValidator.setValue(v);
                              _userName = _userNameController.text;
                            });
                          },
                          isReadOnly: _isreadOnly,
                          validator: userNameValidator,
                          hint: AppStrings.username,
                          onSaved: (v) {},
                        ),
                        IconButton(
                          onPressed: () async {
                            final user = appData.currentUser!.copyWith(
                              username: _userNameController.text,
                            );

                            await Provider.of<AppDataProvider>(
                              context,
                              listen: false,
                            ).updateUser(user, context);
                          },
                          icon: _isreadOnly
                              ? const SizedBox(width: 1, height: 1)
                              : const Icon(Icons.check),
                        ),
                      ],
                    ),
              AppButton(
                width: 200,
                title: AppStrings.addProduct,
                onPressed: () {
                  AppRouter.transition(context, AddProduct());
                },
              ),
              AppButton(
                title: AppStrings.logOut,
                width: 200,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Confirmation"),
                      content: const Text("Are you sure you want to log out?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () {
                            AppRouter.pushArgument(context, Routes.logIn, {
                              "showToast": true,
                            });
                          },
                          child: const Text("log out"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              AppButton(
                width: 200,
                title: AppStrings.deleteAccount,
                backgroundColor: AppColors.red,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Confirmation"),
                      content: const Text(
                        "Are you sure you want to delete your account?",
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Provider.of<AppDataProvider>(
                              context,
                              listen: false,
                            ).deleteuser(appData.currentUser!, context);
                            AppRouter.pushArgument(context, Routes.logIn, {
                              "showToast": true,
                            });
                          },
                          child: const Text("Confirm"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
