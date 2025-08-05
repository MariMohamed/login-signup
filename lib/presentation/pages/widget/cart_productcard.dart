import 'package:flutter/material.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/pages/widget/app_counter.dart';
import 'package:login_signin/presentation/widget/app_inkwell.dart';
import 'package:provider/provider.dart';

class CartProductcard extends StatelessWidget {
  const CartProductcard({super.key, required this.product, required this.cart});
  final Cart cart;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 16,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  product.image,
                  width: 100,
                  height: 100,
                  fit: BoxFit.contain,
                ),
                Expanded(
                  child: Text(
                    product.title,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (product.quantity != null)
                      Text(
                        "Qty: ${product.quantity}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  child: Row(
                    children: [
                      Icon(Icons.delete_forever_rounded),
                      Text(AppStrings.remove),
                    ],
                  ),
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
                Counter(
                  initNumber: product.quantity,
                  counterCallback: (v) async {
                    product.copyWith(quantity: v);
                    cart.products
                            .firstWhere((item) => item.productId == product.id)
                            .quantity =
                        v;
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
    );
  }
}
