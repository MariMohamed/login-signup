import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/data/user_model.dart';
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

  bool _isLoading = true;
  List<Cart> _carts = [];
  List<Product> _products = [];
  List<User> _users = [];
  User? _currentUser;
  // Getters
  bool get isLoading => _isLoading;
  List<Cart> get carts => _carts;
  List<Product> get products => _products;
  List<User> get users => _users;
  User? get currentUser => _currentUser;

  // Load all data
  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();

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
    } catch (e) {
      _isLoading = false;
      // Handle error as needed
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  // Refresh data
  Future<void> refresh() async {
    await loadData();
  }

  Future<void> addUser(User user, context) async {
    final newId = _users.isEmpty ? 1 : _users.last.id! + 1;

    final newUser = user.copyWith(id: newId);

    _isLoading = true;
    notifyListeners();

    final createdUser = await _userListController.signup(newUser, context);
    _users = [..._users, createdUser];
  }

  Future<void> login(String username, String password, context) async {
    _authController.login(
      username: username,
      password: password,
      context: context,
    );
  }

  Future<void> setCurrentUser(List<String> userData) async {
    if (userData.length != 2) {
      throw ArgumentError(
        'userData must contain exactly 2 elements: [username, password]',
      );
    }

    try {
      final username = userData.first;
      final password = userData.last;

      final matchingUser = _users.firstWhere(
        (user) => user.username == username && user.password == password,
        orElse: () => throw Exception('Invalid credentials'),
      );

      _currentUser = matchingUser;
      notifyListeners();
    } catch (e) {
      _currentUser = null;
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updatecart(Cart cart, context) async {
    _cartController.updatecart(cart, context);
    notifyListeners();
  }
}


  // Future<void> updateUser(String userId, User updatedUser) async {
  //   try {
  //     _isLoading = true;
  //     notifyListeners();
      
  //     await _userListController.updateUser(userId, updatedUser);
  //     _users = _users.map((user) => 
  //         user.id == userId ? updatedUser : user).toList();
      
  //   } catch (e) {
  //     throw Exception('Failed to update user: $e');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

