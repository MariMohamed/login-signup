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

  Future<Cart> getCart(int id) async {
    try {
      final response = await apiService.get(path: '${ApiConstants.carts}/$id');
      final Map<String, dynamic> data = response.data;
      if (response.statusCode == 200) {
        Cart cart = Cart.fromJson(data);
        return cart;
      }
      throw Exception(
        'Failed to load cart: Status code ${response.statusCode}',
      );
    } catch (e) {
      rethrow; // == throw(e)
    }
  }

  Future<void> addCart(Cart cart, BuildContext context) async {
    try {
      final response = await apiService.post(
        path: ApiConstants.carts,
        data: cart.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Show success feedback
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cart created successfully'),
            duration: const Duration(seconds: 2),
          ),
        );
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Cart updated successfully!'),
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update cart. Please try again.'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'), // Show actual error
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> deleteCart(Cart cart, BuildContext context) async {
    try {
      final response = await apiService.delete(
        path: '${ApiConstants.carts}/${cart.id}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('deleted created successfully'),
            duration: const Duration(seconds: 2),
          ),
        );
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
    }
  }
}
