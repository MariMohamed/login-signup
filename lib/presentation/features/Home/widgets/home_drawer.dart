import 'package:flutter/material.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/core/providers/app_drawerStateManager.dart';
import 'package:login_signin/presentation/features/Home/view/homescreen.dart';
import 'package:login_signin/presentation/features/Home/widgets/home_useravatar.dart';
import 'package:login_signin/presentation/features/pages/view/app_cartpage.dart';
import 'package:login_signin/presentation/widget/app_inkwell.dart';
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
    final appData = Provider.of<AppDataProvider>(context);
    super.build(context);
    return Consumer<DrawerStateInfo>(
      builder: (context, drawerState, child) {
        return Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: 20,
            children: [
              Container(
                width: double.infinity,
                height: 250,
                color: Theme.of(context).primaryColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 16,
                  children: [
                    Useravatar(),
                    Text(
                      appData.currentUser?.displayName ?? 'Guest',
                      style: TextStyle(color: AppColors.white, fontSize: 20),
                    ),
                  ],
                ),
              ),
              AppInkwell(
                title: AppStrings.home,
                icon: Icons.home,
                onTap: () => AppRouter.transition(context, HomeScreen()),
              ),
              AppInkwell(
                title: AppStrings.cart,
                icon: Icons.shopping_cart,
                onTap: () => AppRouter.transition(context, Cartpage()),
              ),

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
