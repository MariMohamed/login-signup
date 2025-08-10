import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_signin/core/app_assets.dart';

class appBackButton extends StatelessWidget {
  const appBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(AppAssets.backarrow), // Custom back icon
      onPressed: () => Navigator.pop(context),
    );
  }
}
