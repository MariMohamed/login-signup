import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/app_textStyles.dart';
import 'package:login_signin/core/data/cartProduct_model.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/productlist/view/edit_product.dart';
import 'package:login_signin/presentation/features/productlist/widget/app_addtocartview.dart';
import 'package:login_signin/presentation/widget/app_cachedImages.dart';
import 'package:login_signin/presentation/widget/app_circularButton.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key, required this.product});
  final Product product;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool edit = false;

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context);
    return CustomScaffold(
      extend: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(AppAssets.backarrow), // Custom back icon
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          CircularButton(icon: AppAssets.heart, onPressed: () {}),
          CircularButton(
            icon: AppAssets.bag,
            onPressed: () async {
              CartProduct cartProduct = CartProduct(
                productId: widget.product.id,
                quantity: 1,
              );
              try {
                final existingIndex = appData.usercart!.products.indexWhere(
                  (product) => product.productId == cartProduct.productId,
                );

                // 3. Add or update logic
                if (existingIndex == -1) {
                  appData.usercart!.products.add(cartProduct);
                } else {
                  appData.usercart!.products[existingIndex].quantity +=
                      cartProduct.quantity;
                }
                await Provider.of<AppDataProvider>(
                  context,
                  listen: false,
                ).updatecart(appData.usercart!, context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${e.toString()}')),
                );
                return;
              }
            },
          ),
        ],
      ),
      body: Hero(
        tag: widget.product.id,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ProductCachedImage(
                    product: widget.product,
                    height: 900,
                    fit: BoxFit.fill,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    spacing: 16.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.subtotal,
                            style: TextStyles.w400Style,
                          ),
                          Text(
                            '\$${widget.product.price} ',
                            style: TextStyles.w600s24Style,
                          ),
                        ],
                      ),
                      AppButton(
                        onPressed: () {},
                        title: AppStrings.continueString,
                        suffix: SvgPicture.asset(
                          AppAssets.arrow,
                          color: AppColors.white,
                        ),
                        backgroundColor: AppColors.black,
                        width: 140,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
