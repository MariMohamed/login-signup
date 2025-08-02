import 'package:flutter/material.dart';
import 'package:login_signin/core/animation/scale_animation.dart';
import 'package:login_signin/core/animation/vertical_animation.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/presentation/widget/app_card.dart';

class CardGrid extends StatefulWidget {
  const CardGrid({super.key, required this.products});

  final List<Product> products;

  @override
  State<CardGrid> createState() => _CardGridState();
}

class _CardGridState extends State<CardGrid> {
  final GlobalKey<AnimatedGridState> _gridKey = GlobalKey<AnimatedGridState>();
  final Future _future = Future(() {});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      key: _gridKey,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      padding: const EdgeInsets.all(8.0),
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        return ScaleAnimation(child: AppCard(product: widget.products[index]));
      },
    );
  }
}
