import 'package:flutter/material.dart';
import 'package:login_signin/core/animation/vertical_animation.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/data/user_model.dart';
import 'package:login_signin/core/remote/api_constants.dart';
import 'package:login_signin/core/remote/api_service.dart';
import 'package:login_signin/presentation/features/auth/login.dart';

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

  Future<User> getUser(int userid) async {
    try {
      final response = await apiService.get(
        path: '${ApiConstants.users}/${userid}',
      );
      final Map<String, dynamic> data = response.data;
      // debugPrint(response.data.runtimeType.toString());
      if (response.statusCode == 200) {
        return User.fromJson(data);
      }
      throw Exception(
        'Failed to fetch user: Status code ${response.statusCode}',
      );
    } catch (e) {
      throw Exception('Failed to fetch user: ${e.toString()}');
    }
  }

  Future<User> signup(User user, context) async {
    try {
      final response = await apiService.postheader(
        data: user.toJson(),
        path: ApiConstants.users,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;
        return User.fromJson(responseData);
      } else {
        throw Exception('Registration failed: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signup Failed ${e.toString()}')));
      rethrow;
    }
  }

  Future<User> updateUser(User user, context) async {
    try {
      final response = await apiService.update(
        data: user.toJson(),
        path: '${ApiConstants.users}/${user.id}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = response.data as Map<String, dynamic>;
        return User.fromJson(responseData);
      } else {
        throw Exception('Update  failed: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Update Failed ${e.toString()}')));
      rethrow;
    }
  }

  Future<void> deleteUser(User user, context) async {
    try {
      final response = await apiService.update(
        data: user.toJson(),
        path: '${ApiConstants.users}/${user.id}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('User Deleted successfully')));
      } else {
        throw Exception('Update  failed: ${response.statusCode}');
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Update Failed ${e.toString()}')));
      rethrow;
    }
  }
}
