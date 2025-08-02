import 'package:login_signin/core/remote/api_keys.dart';
import 'package:login_signin/presentation/pages/view/product_page.dart';

class Product {
  final int id;
  final String title;
  final num price;
  final String description;
  final String category;
  final String image;
  final Map<String, dynamic> rating;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
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
}
