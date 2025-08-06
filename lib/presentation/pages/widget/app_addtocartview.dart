import 'package:flutter/material.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/pages/widget/app_counter.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';
import 'package:provider/provider.dart';

class Addtocartview extends StatefulWidget {
  const Addtocartview({super.key, required this.product});
  final Product product;

  @override
  State<Addtocartview> createState() => _AddtocartviewState();
}

class _AddtocartviewState extends State<Addtocartview> {
  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppDataProvider>(context);
    late int quantity = 1;
    CartProduct cartProduct = CartProduct(
      productId: widget.product.id,
      quantity: quantity,
    );

    return Column(
      children: [
        Counter(
          initNumber: quantity,
          counterCallback: (v) => setState(() {
            quantity = v;
          }),
        ),
        AppButton(
          title: AppStrings.addtoCart,
          onPressed: () async {
            Cart? cart;
            try {
              cart = appData.carts.firstWhere(
                (cart) => cart.userId == appData.currentUser?.id,
              );
            } on StateError catch (_) {
              cart = null; // No matching element found
            }
            try {
              if (cart == null) {
                cart = Cart(
                  id: appData.carts.length + 1,
                  date: DateTime.now().toString(),
                  userId: appData.currentUser!.id!,
                  products: [cartProduct],
                );
                await Provider.of<AppDataProvider>(
                  context,
                  listen: false,
                ).addcart(cart, context);
              } else {
                cart.products.add(cartProduct);
                await Provider.of<AppDataProvider>(
                  context,
                  listen: false,
                ).updatecart(cart, context);
              }
            } catch (e) {
              // Handle errors
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error updating cart: ${e.toString()}')),
              );
            }
          },
        ),
      ],
    );
  }
}
