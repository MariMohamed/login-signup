import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/app_textStyles.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/Home/widgets/home_useravatar.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Useravatar(),
          Text(appData.currentUser!.displayName, style: TextStyles.w700Style),
          AppButton(
            title: AppStrings.logOut,
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
        ],
      ),
    );
  }
}
