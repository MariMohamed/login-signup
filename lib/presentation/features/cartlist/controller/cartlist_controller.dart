import 'package:flutter/material.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/remote/api_constants.dart';
import 'package:login_signin/core/remote/api_service.dart';

class CartListController {
  final ApiService apiService = ApiService();

  Future<List<Cart>> getCarts() async {
    try {
      final response = await apiService.get(path: ApiConstants.carts);
      final List<dynamic> dataList = response.data as List;
      // debugPrint(response.data.runtimeType.toString());
      if (response.statusCode == 200) {
        return dataList.map((e) => Cart.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow; // == throw(e)
    }
  }

  Future<Cart> addCart(Cart cart, BuildContext context) async {
    try {
      final response = await apiService.post(
        path: ApiConstants.carts,
        data: cart.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Parse the response into a Cart object
        final createdCart = Cart.fromJson(response.data);

        // Show success feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cart created successfully'),
            duration: const Duration(seconds: 2),
          ),
        );

        return createdCart;
      } else {
        throw Exception(
          'Server responded with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Show error feedback
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create cart: ${e.toString()}'),
          duration: const Duration(seconds: 2),
        ),
      );

      // Re-throw to allow callers to handle the error if needed
      rethrow;
    }
  }

  Future<void> updatecart(Cart cart, context) async {
    try {
      final response = await apiService.update(
        data: cart.toJson(),
        path: "${ApiConstants.carts}/${cart.id}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return showDialog(
          barrierDismissible: true,
          context: context,
          builder: (ctx) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop();
            });
            return AlertDialog(content: const Text("Operation success"));
          },
        ).then((value) {
          return value ?? false;
        });
      } else {
        return showDialog(
          barrierDismissible: true,
          context: context,
          builder: (ctx) {
            Future.delayed(const Duration(seconds: 2), () {});
            return AlertDialog(content: const Text("Operation failed"));
          },
        ).then((value) => value ?? false);
      }
    } catch (e) {
      rethrow; // == throw(e)
    }
  }
}
