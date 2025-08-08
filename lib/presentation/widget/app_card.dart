import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login_signin/core/app_assets.dart';
import 'package:login_signin/core/app_colors.dart';
import 'package:login_signin/core/app_textStyles.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/presentation/features/pages/view/product_page.dart';

class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: product.id,
      child: Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductPage(product: product),
              ),
            );
          },
          child: Container(
            color: AppColors.white,
            height: 259,
            width: 160,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          border: Border.all(color: AppColors.white, width: 20),
                        ),
                        width: 160,
                        height: 190,
                        child: Image.network(
                          product.image,
                          width: 160,
                          height: 190,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Positioned(
                        child: InkWell(
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(60),
                              ),
                              border: Border.all(
                                color: AppColors.white,
                                width: 5,
                              ),
                              color: AppColors.black,
                            ),
                            child: SvgPicture.asset(
                              AppAssets.bag,
                              width: 14,
                              height: 14,
                              color: AppColors.white,
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        product.title,
                        style: TextStyles.w400Style,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        '£${product.price} ',
                        style: TextStyles.w600s14Style,
                      ),
                    ],
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
