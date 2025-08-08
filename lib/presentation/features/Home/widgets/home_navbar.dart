import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/presentation/features/Home/view/homescreen.dart';
import 'package:login_signin/presentation/features/pages/view/profile_page.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 62,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () => AppRouter.transition(context, HomeScreen()),
            icon: SvgPicture.asset(AppAssets.home, fit: BoxFit.cover),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppAssets.heart, fit: BoxFit.cover),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              AppAssets.notificationBing,
              fit: BoxFit.cover,
            ),
          ),
          IconButton(
            onPressed: () => AppRouter.transition(context, ProfilePage()),
            icon: SvgPicture.asset(AppAssets.profile, fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }
}
