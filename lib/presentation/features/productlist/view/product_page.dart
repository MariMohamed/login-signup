import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/providers/app_dataprovider.dart';
import 'package:login_signin/presentation/features/productlist/view/edit_product.dart';
import 'package:login_signin/presentation/features/productlist/widget/app_addtocartview.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key, required this.product});
  final Product product;
  bool edit = false;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
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
              ).deleteproduct(product, context);
              Navigator.pop(context);
            },
            icon: Icon(Icons.delete),
          ),
          IconButton(
            onPressed: () async {
              AppRouter.transition(context, EditProduct(product: product));
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Hero(
        tag: product.id,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.loose,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 400,
                  child: Image.network(product.image, fit: BoxFit.contain),
                ),

                Positioned(
                  top: 350,
                  left: 0,
                  right: 0,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBarIndicator(
                              rating: product.rating.values.first,
                              itemCount: 5,
                              itemSize: 20.0,
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),

                            Text(
                              '\$${product.price} ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Text(
                          product.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Addtocartview(product: product),
                      ],
                    ),
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
