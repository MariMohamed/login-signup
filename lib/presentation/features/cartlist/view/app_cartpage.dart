import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signin/core/animation/scale_animation.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/app_textStyles.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/cartlist/widget/cart_productcard.dart';
import 'package:login_signin/presentation/widget/AppBackbutton.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';
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
    double subTotal = 0;
    cartProducts.forEach((product) {
      subTotal += product.price * product.quantity!;
    });
    double shipping = 5;
    double total = subTotal + shipping;
    return appData.isLoading
        ? Center(child: CircularProgressIndicator())
        : CustomScaffold(
            appBar: AppBar(
              toolbarHeight: 48,
              leading: appBackButton(),
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
                    await Provider.of<AppDataProvider>(
                      context,
                      listen: false,
                    ).initializeUserCart(context);
                    setState(() {});
                  },
                  icon: Icon(Icons.delete_forever),
                ),
              ],

              title: Text(AppStrings.cart, style: TextStyles.w600s24Style),
              centerTitle: true,
            ),
            body: cartProducts.isEmpty
                ? const Center(child: Text('Your cart is empty'))
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
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
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0, top: 16),
                          child: SizedBox(
                            width: 335,

                            child: Column(
                              spacing: 16,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.subtotal,
                                      style: TextStyles.w400s14Style,
                                    ),
                                    Text(
                                      "\$$subTotal",
                                      style: TextStyles.w600s16Style,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.shipping,
                                      style: TextStyles.w400s14Style,
                                    ),
                                    Text(
                                      "\$$shipping",
                                      style: TextStyles.w600s16Style,
                                    ),
                                  ],
                                ),
                                SvgPicture.asset(AppAssets.dots),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppStrings.total,
                                      style: TextStyles.w400s14Style,
                                    ),
                                    Text(
                                      "\$$total",
                                      style: TextStyles.w600s16Style,
                                    ),
                                  ],
                                ),

                                AppButton(
                                  onPressed: () {},
                                  backgroundColor: AppColors.black,
                                  width: 335,
                                  height: 49,
                                  title: AppStrings.checkOut,
                                  suffix: Center(
                                    child: SvgPicture.asset(
                                      AppAssets.arrow,
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
  }
}
