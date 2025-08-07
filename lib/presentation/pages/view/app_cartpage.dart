import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signin/core/animation/scale_animation.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/app_textStyles.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/Home/widgets/home_drawer.dart';
import 'package:login_signin/presentation/pages/widget/cart_productcard.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:provider/provider.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({
    super.key, // required this.cart
  });

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context);
    List<Product> cartProducts;
    if (appData.usercart!.products.isNotEmpty) {
      cartProducts = appData.usercart!.products.map((cartProduct) {
        final product = appData.products.firstWhere(
          (p) => p.id == cartProduct.productId,
        );
        return product.copyWith(quantity: cartProduct.quantity);
      }).toList();
    } else {
      cartProducts = [];
    }
    if (appData.usercart == null) {
      return const Center(
        child: Text("No cart"), // Or a "No cart" message
      );
    }
    return appData.isLoading
        ? Center(child: CircularProgressIndicator())
        : CustomScaffold(
            appBar: AppBar(
              leading: AppBar(
                leading: IconButton(
                  icon: SvgPicture.asset(
                    AppAssets.backarrow,
                  ), // Custom back icon
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              title: Text(AppStrings.cart, style: TextStyles.w600s16Style),
              centerTitle: true,
            ),
            body: cartProducts.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (buildcontext, index) {
                      return ScaledAnimation(
                        child: CartProductcard(
                          product: cartProducts[index],
                          cart: appData.usercart!,
                        ),
                      );
                    },
                  ),
          );
  }
}
