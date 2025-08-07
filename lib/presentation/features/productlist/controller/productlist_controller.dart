import 'package:flutter/material.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/remote/api_constants.dart';
import 'package:login_signin/core/remote/api_service.dart';

class ProductListController {
  final ApiService apiService = ApiService();

  Future<List<Product>> getProducts() async {
    try {
      final response = await apiService.get(path: ApiConstants.products);
      final List<dynamic> dataList = response.data as List;
      // debugPrint(response.data.runtimeType.toString());
      if (response.statusCode == 200) {
        return dataList.map((e) => Product.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow; // == throw(e)
    }
  }

  Future<Product> getProduct() async {
    try {
      final response = await apiService.get(path: ApiConstants.products);
      final Map<String, dynamic> data = response.data;
      // debugPrint(response.data.runtimeType.toString());
      if (response.statusCode == 200) {
        return Product.fromJson(data);
      }
      throw Exception(
        'Failed to load product: Status code ${response.statusCode}',
      );
    } catch (e) {
      rethrow; // == throw(e)
    }
  }

  Future<Product> addProduct(Product product) async {
    try {
      final response = await apiService.post(
        path: ApiConstants.products,
        data: product.toJson(),
      );
      final Map<String, dynamic> data = response.data;
      // debugPrint(response.data.runtimeType.toString());
      if (response.statusCode == 200) {
        return Product.fromJson(data);
      }
      throw Exception(
        'Failed to add product: Status code ${response.statusCode}',
      );
    } catch (e) {
      rethrow; // == throw(e)
    }
  }

  Future<Product> updateProduct(Product product) async {
    try {
      final response = await apiService.update(
        path: '${ApiConstants.products}/${product.id}',
        data: product.toJson(),
      );
      final Map<String, dynamic> data = response.data;
      if (response.statusCode == 200) {
        return Product.fromJson(data);
      }
      throw Exception(
        'Failed to update product: Status code ${response.statusCode}',
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(Product product, context) async {
    try {
      final response = await apiService.delete(
        path: '${ApiConstants.products}/${product.id}',
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Product deleted successfully'),
            duration: const Duration(seconds: 2),
          ),
        );
      }
      throw Exception(
        'Failed to update product: Status code ${response.statusCode}',
      );
    } catch (e) {
      rethrow; // == throw(e)
    }
  }
}
