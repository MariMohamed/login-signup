import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signin/core/animation/scale_animation.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/app_textStyles.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/cartlist/widget/cart_productcard.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:provider/provider.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({
    super.key, // required this.cart
  });

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
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
              leading: IconButton(
                icon: SvgPicture.asset(AppAssets.backarrow), // Custom back icon
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  onPressed: () async {
                    await Provider.of<AppDataProvider>(
                      context,
                      listen: false,
                    ).deletecart(appData.usercart!, context);
                    final index = appData.carts.indexWhere(
                      (cart) => cart.id == appData.usercart!.id,
                    );
                    if (index != -1) {
                      appData.carts.removeAt(index);
                    }
                    print(appData.usercart);
                    await Provider.of<AppDataProvider>(
                      context,
                      listen: false,
                    ).initializeUserCart(context);
                    setState(() {});
                  },
                  icon: Icon(Icons.delete_forever),
                ),
              ],

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
