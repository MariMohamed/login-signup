import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/core/data/products_model.dart';

class ProductCachedImage extends StatelessWidget {
  final Product product;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  const ProductCachedImage({
    required this.product,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return FastCachedImage(
      url: product.image,
      width: width,
      height: height,
      fit: fit,
      key: ValueKey(product.imageCacheKey),
      fadeInDuration: const Duration(milliseconds: 200),
    );
  }
}
