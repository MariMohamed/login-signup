import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/app_textStyles.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/widget/app_cachedImages.dart';
import 'package:login_signin/presentation/widget/app_counter.dart';
import 'package:provider/provider.dart';

class CartProductcard extends StatelessWidget {
  const CartProductcard({super.key, required this.product, required this.cart});
  final Cart cart;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 16,
          children: [
            ProductCachedImage(
              product: product,
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),

            SizedBox(
              height: 110,
              width: 290,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                spacing: 8,
                children: [
                  Expanded(
                    child: Text(
                      product.title,
                      style: TextStyles.w400s14Style,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "\$${product.price.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Counter(
                        initNumber: product.quantity,
                        counterCallback: (v) async {
                          product.copyWith(quantity: v);
                          cart.products
                                  .firstWhere(
                                    (item) => item.productId == product.id,
                                  )
                                  .quantity =
                              v;
                          await Provider.of<AppDataProvider>(
                            context,
                            listen: false,
                          ).updatecart(cart, context);
                        },
                      ),
                      IconButton(
                        icon: SvgPicture.asset(AppAssets.trash),
                        onPressed: () async {
                          cart.products.removeWhere(
                            (item) => item.productId == product.id,
                          );
                          await Provider.of<AppDataProvider>(
                            context,
                            listen: false,
                          ).updatecart(cart, context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
