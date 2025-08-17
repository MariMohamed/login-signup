import 'package:hive/hive.dart';
import 'package:login_signin/core/remote/api_keys.dart';

part 'cartProduct_model.g.dart';

@HiveType(typeId: 1)
class CartProduct {
  @HiveField(0)
  final int productId;
  @HiveField(1)
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
  CartProduct copyWith({int? productId, int? quantity}) {
    return CartProduct(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }
}
