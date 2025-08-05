import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:login_signin/core/animation/scale_animation.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/presentation/widget/app_card.dart';

class CardGrid extends StatefulWidget {
  const CardGrid({super.key, required this.products});

  final List<Product> products;

  @override
  State<CardGrid> createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          childAspectRatio: 0.85,
        ),
        padding: const EdgeInsets.all(16.0),
        itemCount: widget.products.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 500),
            columnCount: 2,
            child: ScaledAnimation(
              duration: const Duration(milliseconds: 400),
              child: FadeInAnimation(
                child: AppCard(product: widget.products[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
