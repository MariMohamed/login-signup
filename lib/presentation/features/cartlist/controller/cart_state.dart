import 'package:login_signin/core/data/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartsLoaded extends CartState {
  final List<Cart> carts;
  CartsLoaded(this.carts);
}

class CartLoaded extends CartState {
  final Cart cart;
  CartLoaded(this.cart);
}

class CartOperationSuccess extends CartState {
  final String message;
  CartOperationSuccess(this.message);
}

class CartError extends CartState {
  final String error;
  CartError(this.error);
}
