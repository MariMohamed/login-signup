import 'package:hive/hive.dart';
import 'package:login_signin/core/data/cartProduct_model.dart';
import 'package:login_signin/core/remote/api_keys.dart';
part 'cart_model.g.dart';

@HiveType(typeId: 0)
class Cart {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String date;
  @HiveField(2)
  final int userId;
  @HiveField(3)
  final List<CartProduct> products;
  @HiveField(4)
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
