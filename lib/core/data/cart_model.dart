import 'package:flutter/material.dart';
import 'package:login_signin/core/remote/api_keys.dart';

class Cart {
  final int id;
  final String date;
  final int userId;
  final List<dynamic> products;

  const Cart({
    required this.id,
    required this.date,
    required this.userId,
    required this.products,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json[ApiKeys.id],
      date: json[ApiKeys.date],
      userId: json[ApiKeys.userId],
      products: json[ApiKeys.products],
    );
  }
  Map<String, dynamic> toJson() => {
    ApiKeys.id: id,
    ApiKeys.date: date,
    ApiKeys.userId: userId,
    ApiKeys.products: products,
  };
}
