import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:login_signin/core/app_router.dart';
import 'package:login_signin/core/data/auth_model.dart';
import 'package:login_signin/core/remote/api_constants.dart';
import 'package:login_signin/core/remote/api_service.dart';

class AuthController {
  final ApiService apiService = ApiService();

  Future<void> login({
    required String username,
    required String password,
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.postheader(
        path: ApiConstants.auth,
        data: Auth(username: username.trim(), password: password).tologinJson(),
        headers: {
          'Content-Type': 'application/json', // Explicitly set content type
        },
      );

      if (response.statusCode == 200) {
        if (context.mounted) {
          await AppRouter.push(context, Routes.home);
        }
        return;
      }

      // Handle specific error cases
      _handleErrorResponse(response, context);
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        _handleErrorResponse(e.response!, context);
      } else {
        _showErrorDialog(
          context,
          title: "Network Error",
          message: "Please check your internet connection",
        );
      }
    } catch (e) {
      _showErrorDialog(
        context,
        title: "Unexpected Error",
        message: "An unexpected error occurred. Please try again.",
      );
      rethrow;
    }
  }

  void _handleErrorResponse(Response response, BuildContext context) {
    final statusCode = response.statusCode;
    final errorData = response.data;

    if (!context.mounted) return;

    switch (statusCode) {
      case 400:
        final errorMessage =
            errorData['message'] ??
            "Invalid email or password. Please try again.";
        _showErrorDialog(context, message: errorMessage);
        break;
      case 401:
        _showErrorDialog(context, message: "Unauthorized access");
        break;
      case 403:
        _showErrorDialog(context, message: "Forbidden: Access denied");
        break;
      case 404:
        _showErrorDialog(context, message: "Resource not found");
        break;
      case 500:
        _showErrorDialog(context, message: "Server error. Please try later");
        break;
      default:
        _showErrorDialog(
          context,
          message: "Request failed with status $statusCode",
        );
    }
  }

  Future<void> _showErrorDialog(
    BuildContext context, {
    String title = "Error",
    required String message,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
