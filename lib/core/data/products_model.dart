import 'package:hive/hive.dart';
import 'package:login_signin/core/remote/api_keys.dart';

part 'products_model.g.dart';

@HiveType(typeId: 2)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  num price;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String category;
  @HiveField(5)
  final String image;
  @HiveField(6)
  final Map<String, dynamic> rating;
  @HiveField(7)
  final int? quantity;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json[ApiKeys.id],
      title: json[ApiKeys.title],
      price: json[ApiKeys.price],
      description: json[ApiKeys.description],
      category: json[ApiKeys.category],
      image: json[ApiKeys.image],
      rating: json[ApiKeys.rating],
    );
  }

  Product copyWith({
    int? id,
    String? title,
    num? price,
    String? description,
    String? category,
    String? image,
    Map<String, dynamic>? rating,
    int? quantity,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toJson() => {
    ApiKeys.id: id,
    ApiKeys.title: title,
    ApiKeys.price: price,
    ApiKeys.description: description,
    ApiKeys.image: image,
    ApiKeys.rating: rating,
  };
}
