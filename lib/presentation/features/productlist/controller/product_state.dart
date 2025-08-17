import 'package:login_signin/core/data/products_model.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductsLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Product> products;
  ProductsLoaded(this.products);
}

class ProductLoaded extends ProductState {
  final Product product;
  ProductLoaded(this.product);
}

class ProductOperationSuccess extends ProductState {
  final String message;
  ProductOperationSuccess(this.message);
}

class ProductError extends ProductState {
  final String error;
  ProductError(this.error);
}
