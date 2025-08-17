import 'package:bloc/bloc.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/remote/api_constants.dart';
import 'package:login_signin/core/remote/api_service.dart';
import 'package:login_signin/presentation/features/cartlist/controller/cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final ApiService apiService;

  CartCubit({required this.apiService}) : super(CartInitial());
  Future<void> getCarts() async {
    emit(CartLoading());
    try {
      final response = await apiService.get(path: ApiConstants.carts);
      final List<dynamic> dataList = response.data as List;
      // debugPrint(response.data.runtimeType.toString());
      if (response.statusCode == 200) {
        List<Cart> carts = dataList.map((e) => Cart.fromJson(e)).toList();
        emit(CartsLoaded(carts));
      } else {
        emit(
          CartError('Failed to load carts: Status code ${response.statusCode}'),
        );
      }
    } catch (e) {
      emit(CartError(' ${e.toString()}'));
    }
  }

  Future<void> getCart(int id) async {
    try {
      final response = await apiService.get(path: '${ApiConstants.carts}/$id');
      final Map<String, dynamic> data = response.data;
      if (response.statusCode == 200) {
        Cart cart = Cart.fromJson(data);
        emit(CartLoaded(cart));
      } else {
        emit(
          CartError('Failed to load cart: Status code ${response.statusCode}'),
        );
      }
    } catch (e) {
      emit(CartError(' ${e.toString()}')); // == throw(e)
    }
  }

  Future<void> addCart(Cart cart) async {
    emit(CartLoading());
    try {
      final response = await apiService.post(
        path: ApiConstants.carts,
        data: cart.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CartOperationSuccess('Cart created successfully'));
        getCarts(); // Refresh the cart list
      } else {
        emit(
          CartError(
            'Server responded with status code: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(CartError('Failed to create cart: ${e.toString()}'));
    }
  }

  Future<void> updateCart(Cart cart) async {
    emit(CartLoading());
    try {
      final response = await apiService.update(
        data: cart.toJson(),
        path: "${ApiConstants.carts}/${cart.id}",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CartOperationSuccess('Cart updated successfully'));
        getCarts(); // Refresh the cart list
      } else {
        emit(CartError('Failed to update cart. Please try again.'));
      }
    } catch (e) {
      emit(CartError('Error: ${e.toString()}'));
    }
  }

  Future<void> deleteCart(Cart cart) async {
    emit(CartLoading());
    try {
      final response = await apiService.delete(
        path: '${ApiConstants.carts}/${cart.id}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(CartOperationSuccess('Cart deleted successfully'));
        getCarts(); // Refresh the cart list
      } else {
        emit(
          CartError(
            'Server responded with status code: ${response.statusCode}',
          ),
        );
      }
    } catch (e) {
      emit(CartError('Failed to delete cart: ${e.toString()}'));
    }
  }

  void increaseQuantity(Cart cart, int productId) async {
    try {
      final updatedProducts = cart.products.map((product) {
        if (product.productId == productId) {
          return product.copyWith(quantity: product.quantity + 1);
        }
        return product;
      }).toList();

      final updatedCart = cart.copyWith(products: updatedProducts);
      await updateCart(updatedCart);
    } catch (e) {
      emit(CartError('Failed to increase quantity: ${e.toString()}'));
    }
  }

  void decreaseQuantity(Cart cart, int productId) async {
    try {
      final updatedProducts = cart.products.map((product) {
        if (product.productId == productId) {
          return product.copyWith(quantity: product.quantity - 1);
        }
        return product;
      }).toList();

      final updatedCart = cart.copyWith(products: updatedProducts);
      await updateCart(updatedCart);
    } catch (e) {
      emit(CartError('Failed to increase quantity: ${e.toString()}'));
    }
  }

  double get subtotal =>
}
