import 'package:flutter/material.dart';
import 'package:login_signin/core/animation/scale_animation.dart';
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
    final Cart cart = appData.carts.firstWhere(
      (cart) => cart.userId == appData.currentUser?.id,
      orElse: () => throw Exception('User not found'),
    );

    final List<Product> cartProducts = cart.products.map((cartProduct) {
      final product = appData.products.firstWhere(
        (p) => p.id == cartProduct.productId,
      );
      return product.copyWith(quantity: cartProduct.quantity);
    }).toList();

    return CustomScaffold(
      drawer: HomeDrawer(),
      implyleading: true,
      body: cartProducts.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
              itemCount: cartProducts.length,
              itemBuilder: (buildcontext, index) {
                return ScaledAnimation(
                  child: CartProductcard(
                    product: cartProducts[index],
                    cart: cart,
                  ),
                );
              },
            ),
    );
  }
}
