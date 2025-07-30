import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/manager/theme/app_drawerStateManager.dart';
import 'package:login_signin/presentation/features/Home/widgets/home_useravatar.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<DrawerStateInfo>(
      builder: (context, drawerState, child) {
        return Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              HomeUseravatar(),
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
      },
    );
  }
}
