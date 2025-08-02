import 'package:flutter/material.dart';
import 'package:login_signin/core/animation/vertical_animation.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/data/user_model.dart';
import 'package:login_signin/presentation/features/Home/widgets/home_drawer.dart';
import 'package:login_signin/presentation/features/cartlist/controller/cartlist_controller.dart';
import 'package:login_signin/presentation/features/productlist/controller/productlist_controller.dart';
import 'package:login_signin/presentation/features/userlist/controller/uselist_controller.dart';
import 'package:login_signin/presentation/widget/app_card.dart';
import 'package:login_signin/presentation/widget/app_cardGrid.dart';
import 'package:login_signin/presentation/widget/app_center.dart';
import 'package:login_signin/presentation/widget/appbutton.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/app_strings.dart';
import 'package:login_signin/presentation/widget/custom_scaffold.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CartListController cartListController = CartListController();
  final ProductListController productListController = ProductListController();

  bool isLoading = true;

  List<Cart> carts = [];
  List<Product> products = [];
  List<User> users = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final results = await cartListController.getCarts();
    final productResults = await productListController.getProducts();
    setState(() {
      carts = results;
      isLoading = false;
      products = productResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : CustomScaffold(
            drawer: HomeDrawer(),
            implyleading: true,
            body: CardGrid(products: products),
          );
  }
}
