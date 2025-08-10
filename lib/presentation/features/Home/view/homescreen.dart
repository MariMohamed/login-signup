import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/app_textStyles.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/Home/widgets/home_navbar.dart';
import 'package:login_signin/presentation/features/cartlist/view/app_cartpage.dart';
import 'package:login_signin/presentation/features/Home/widgets/home_buttonCollection.dart';
import 'package:login_signin/presentation/widget/app_cardGrid.dart';
import 'package:login_signin/presentation/widget/app_textfield.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context);
    return appData.isLoading
        ? Center(child: CircularProgressIndicator())
        : CustomScaffold(
            navBar: HomeNavbar(),
            appBar: AppBar(
              backgroundColor: AppColors.white,
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              toolbarHeight: 80,
              title: Padding(
                padding: const EdgeInsets.only(left: 25.0, top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Welcome Back!", style: TextStyles.w400Style),
                    Text("Falcon Thought", style: TextStyles.w600Style),
                  ],
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 8),
                  child: Center(
                    child: Stack(
                      children: [
                        IconButton(
                          onPressed: () =>
                              AppRouter.transition(context, Cartpage()),
                          icon: SvgPicture.asset(
                            AppAssets.notification,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.red,
                              border: Border.all(color: Colors.white, width: 1),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Center(
                                child: Text(
                                  appData.usercart?.products.length
                                          .toString() ??
                                      "0",
                                  style: TextStyles.w600Style.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.only(top: 16, bottom: 16),
                    child: Container(
                      width: 335,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.container,
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                      ),
                      child: TextField(
                        textAlign: TextAlign.justify,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: SizedBox(
                            width: 14,
                            height: 14,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SvgPicture.asset(
                                AppAssets.search,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          hint: Text(
                            AppStrings.search,
                            style: TextStyles.w400Style,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 160,
                    width: 335,
                    decoration: BoxDecoration(
                      color: AppColors.container,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 166,
                                height: 86,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Shop with us!",
                                      style: TextStyles.w400s14Style,
                                    ),
                                    Text(
                                      'Get 40% Off for all items',
                                      style: TextStyles.w700Style,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                spacing: 12,
                                children: [
                                  Text(
                                    'Shop Now',
                                    style: TextStyles.w700s12Style,
                                  ),
                                  SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: SvgPicture.asset(AppAssets.arrow),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Image.asset(AppAssets.model, width: 130, height: 173),
                        ],
                      ),
                    ),
                  ),
                  //CardGrid(products: appData.products),
                  Buttoncollection(),
                ],
              ),
            ),
          );
  }
}
