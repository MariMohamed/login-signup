import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:login_signin/core/data/cartProduct_model.dart';
import 'package:login_signin/core/data/cart_model.dart';
import 'package:login_signin/core/data/products_model.dart';
import 'package:login_signin/core/data/user_model.dart';

const String cacheKey = 'cache';

class HiveSetup {
  static Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CartProductAdapter());
    Hive.registerAdapter(CartAdapter());
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(UserAdapter());

    await Hive.openBox(cacheKey);
  }
}
