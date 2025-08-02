import 'package:flutter/material.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';

class PageTemp extends StatelessWidget {
  const PageTemp({super.key, required this.cart});
  final Cart cart;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      implyleading: true,
      body: Hero(
        tag: cart.id,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    spreadRadius: 5,
                    blurRadius: 10.0,
                    offset: Offset(0, -20.0),
                  ),
                ],
              ),
              child: Column(
                spacing: 16.0,
                children: [
                  Text(
                    "CartID: ${cart.id}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    "Date: ${cart.date}",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'UserID: ${cart.userId}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: cart.products.length,
                      itemBuilder: (context, index) {
                        return Text("${cart.products[index]}");
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
