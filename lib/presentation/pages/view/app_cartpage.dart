import 'package:flutter/material.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/Home/widgets/home_drawer.dart';
import 'package:login_signin/presentation/widget/app_cardGrid.dart';
import 'package:login_signin/presentation/widget/app_center.dart';
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
    bool test(Product product) {
      return cart.products.any(
        (cartProduct) => cartProduct.productId == product.id,
      );
    }

    ;
    final List<Product> cartProducts = appData.products.where(test).toList();
    return CustomScaffold(
      drawer: HomeDrawer(),
      implyleading: true,
      body: cartProducts.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : AppCenter(children: [CardGrid(products: cartProducts)]),
    );
  }
}
