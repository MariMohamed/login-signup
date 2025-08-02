import 'package:flutter/material.dart';
import 'package:login_signin/core/animation/vertical_animation.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/data/user_model.dart';
import 'package:login_signin/core/remote/api_constants.dart';
import 'package:login_signin/core/remote/api_service.dart';
import 'package:login_signin/presentation/features/auth/login.dart';
import 'package:login_signin/presentation/features/auth/signup.dart';

class UserListController {
  final ApiService apiService = ApiService();

  Future<List<User>> getUsers() async {
    try {
      final response = await apiService.get(path: ApiConstants.users);
      final List<dynamic> dataList = response.data as List;
      // debugPrint(response.data.runtimeType.toString());
      if (response.statusCode == 200) {
        return dataList.map((e) => User.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      rethrow; // == throw(e)
    }
  }

  Future<User> signup(User user, context) async {
    try {
      final response = await apiService.post(
        data: user.toJson(),
        path: ApiConstants.users,
      );

      if (response.statusCode == 200) {
        return showDialog(
          barrierDismissible: true,
          context: context,
          builder: (ctx) {
            Future.delayed(const Duration(seconds: 2), () {
              Navigator.of(context).pop();
              AppRouter.transition(context, VerticalAnimation(child: LogIn()));
            });
            return AlertDialog(content: const Text("Registered succesfully"));
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
            return AlertDialog(content: const Text("Registeration Failed"));
          },
        ).then((value) => value ?? false);
      }
    } catch (e) {
      rethrow; // == throw(e)
    }
  }
}
