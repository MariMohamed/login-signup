import 'package:login_signin/core/remote/api_keys.dart';

class Cart {
  final int id;
  final String date;
  final int userId;
  final List<CartProduct> products;
  final int version;

  const Cart({
    required this.id,
    required this.date,
    required this.userId,
    required this.products,
    this.version = 0,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json[ApiKeys.id],
      date: json[ApiKeys.date],
      userId: json[ApiKeys.userId],
      products: (json[ApiKeys.products] as List)
          .map((product) => CartProduct.fromJson(product))
          .toList(),
      version: json[ApiKeys.v] as int,
    );
  }
  Map<String, dynamic> toJson() => {
    ApiKeys.id: id,
    ApiKeys.date: date,
    ApiKeys.userId: userId,
    ApiKeys.products: products.map((product) => product.toJson()).toList(),
    ApiKeys.v: version,
  };
}

class CartProduct {
  final int productId;
  int quantity;

  CartProduct({required this.productId, required this.quantity});

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json[ApiKeys.productId] as int,
      quantity: json[ApiKeys.quantity] as int,
    );
  }

  Map<String, dynamic> toJson() => {
    ApiKeys.productId: productId,
    ApiKeys.quantity: quantity,
  };
}
