import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/connection/networkInfo.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/data/user_model.dart';
import 'package:login_signin/core/firebase/auth.dart';
import 'package:login_signin/core/hive/hive_setup.dart';
import 'package:login_signin/core/manager/shared_preferences_manager.dart';
import 'package:login_signin/presentation/features/auth/controller/auth_controller.dart';
import 'package:login_signin/presentation/features/cartlist/controller/cartlist_controller.dart';
import 'package:login_signin/presentation/features/productlist/controller/productlist_controller.dart';
import 'package:login_signin/presentation/features/userlist/controller/uselist_controller.dart';
import 'package:flutter/foundation.dart';

class AppDataProvider with ChangeNotifier {
  final CartListController _cartController = CartListController();
  final ProductListController _productController = ProductListController();
  final UserListController _userListController = UserListController();
  final AuthController _authController = AuthController();
  final _hiveBox = Hive.box(cacheKey);
  final NetworkInfo _networkInfo = NetworkInfo(connectivity: Connectivity());
  bool _isLoading = true;
  List<Cart> _carts = [];
  List<Product> _products = [];
  List<User> _users = [];
  User? _currentUser;
  Cart? _usercart;
  // Getters
  bool get isLoading => _isLoading;
  List<Cart> get carts => _carts;
  List<Product> get products => _products;
  List<User> get users => _users;
  User? get currentUser => _currentUser;
  Cart? get usercart => _usercart;
  //get data offline
  Future<void> _loadFromCache() async {
    try {
      final cachedCarts = _hiveBox.get(0, defaultValue: <Cart>[]) as List;
      final cachedProducts = _hiveBox.get(2, defaultValue: <Product>[]) as List;
      final cachedUsers = _hiveBox.get(3, defaultValue: <User>[]) as List;

      // Safe type conversion with fallback
      _carts = List<Cart>.from(cachedCarts.whereType<Cart>());
      _products = List<Product>.from(cachedProducts.whereType<Product>());
      _users = List<User>.from(cachedUsers.whereType<User>());

      print('Cache loaded successfully');
      _isLoading = false;
    } catch (e) {
      print('Cache loading error: $e');
      // Fallback to empty lists
      _carts = [];
      _products = [];
      _users = [];
      _isLoading = false;
    }
  }

  // Load all data
  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();
    if (await _networkInfo.isConnected) {
      try {
        final List<dynamic> results = await Future.wait([
          _cartController.getCarts(),
          _productController.getProducts(),
          _userListController.getUsers(),
        ]);

        _carts = results[0];
        _products = results[1];
        _users = results[2];
        _isLoading = false;
        _currentUser;
        _hiveBox.put(0, _carts);
        _hiveBox.put(2, _products);
        _hiveBox.put(3, _users);
      } catch (e) {
        _isLoading = false;

        rethrow;
      } finally {
        notifyListeners();
      }
    } else {
      _loadFromCache();
    }
  }

  // Refresh data
  Future<void> refresh() async {
    await loadData();
  }

  Future<User?> addUser(User user, BuildContext context) async {
    try {
      final newId = _users.isEmpty ? 1 : _users.last.id! + 1;
      final newUser = user.copyWith(id: newId);

      _isLoading = true;
      notifyListeners();

      // 1. First handle the signup (which returns bool)
      final User createdUser = await _userListController.signup(
        newUser,
        context,
      );
      _users = [..._users, createdUser];

      // Attempt login
      try {
        await _authController.login(
          username: createdUser.username,
          password: createdUser.password,
          context: context,
        );

        // If we get here, login succeeded
        _users = [..._users, createdUser];
        Navigator.of(context).pushReplacementNamed('/home');
        return newUser;
      } catch (loginError) {
        throw Exception('Login failed after signup: $loginError');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      return null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login(String username, String password, context) async {
    _authController.login(
      username: username,
      password: password,
      context: context,
    );

    //_initializeUserCart(context);
  }

  Future<void> setCurrentUser(List<String> userData) async {
    final AuthService _auth = AuthService();
    final user = _auth.getUser();
    // if (userData.length != 2) {
    //   throw ArgumentError(
    //     'userData must contain exactly 2 elements: [username, password]',
    //   );
    // }

    // try {
    //   final username = userData.first;
    //   final password = userData.last;

    //   final matchingUser = _users.firstWhere(
    //     (user) => user.username == username && user.password == password,
    //     orElse: () => throw Exception('Invalid credentials'),
    //   );

    //   _currentUser = matchingUser;
    //   notifyListeners();
    // } catch (e) {
    //   _currentUser = null;
    //   notifyListeners();
    //   rethrow;
    // }
  }

  Future<void> addcart(Cart cart, context) async {
    _cartController.addCart(cart, context);
    notifyListeners();
  }

  Future<void> initializeUserCart(context) async {
    try {
      // Try to find existing cart
      _usercart = _carts.firstWhere(
        (cart) => cart.userId == _currentUser?.id,
        orElse: () => Cart(
          // Return a new cart if none exists
          id: _carts.length + 1,
          date: DateTime.now().toString(),
          userId: _currentUser!.id!,
          products: [],
          version: 0,
        ),
      );

      if (!_carts.any((cart) => cart.userId == _currentUser?.id)) {
        await _cartController.addCart(_usercart!, context);
        _carts.add(_usercart!);
      }
    } catch (e) {
      debugPrint('Error initializing user cart: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to load cart data')));
    }
  }

  Future<void> updatecart(Cart cart, context) async {
    _cartController.updatecart(cart, context);
    notifyListeners();
  }

  Future<void> deletecart(Cart cart, context) async {
    _cartController.deleteCart(cart, context);
    notifyListeners();
  }

  Future<void> updateUser(User user, context) async {
    _currentUser = await _userListController.updateUser(user, context);

    notifyListeners();
  }

  Future<void> deleteuser(User user, context) async {
    await _userListController.deleteUser(user, context);
    final index = _users.indexWhere((users) => users.id == user.id);
    if (index != -1) {
      _users.removeAt(index);
    }
    notifyListeners();
  }

  Future<void> deleteproduct(Product product, context) async {
    await _productController.deleteProduct(product, context);
    final index = _products.indexWhere(
      (listproduct) => listproduct.id == product.id,
    );
    if (index != -1) {
      _products.removeAt(index);
    }
    final cartindex = _usercart!.products.indexWhere(
      (listproduct) => listproduct.productId == product.id,
    );
    if (cartindex != -1) {
      _usercart!.products.removeAt(cartindex);
    }
    notifyListeners();
  }

  Future<void> updateproduct(Product updatedProduct, context) async {
    await _productController.updateProduct(updatedProduct);
    final index = _products.indexWhere((p) => p.id == updatedProduct.id);
    if (index != -1) {
      _products[index] = updatedProduct;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> addproduct(Product product, context) async {
    await _productController.addProduct(product);
    _products.add(product);
    notifyListeners();
  }

  Future<bool> initializeUserFromToken(BuildContext context) async {
    try {
      // Get stored user credentials (if you're storing them)
      final storedUser = SharedPreferencesManager.getUser();
      final token = SharedPreferencesManager.getToken();

      if (storedUser != null && token != null) {
        // Initialize current user from stored data
        await setCurrentUser([storedUser[0], storedUser[1]]);
        await initializeUserCart(context);

        // Navigate to home screen
        AppRouter.push(context, Routes.home);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Session expired. Please login again.');
    }
  }
}
