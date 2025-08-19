import 'package:dio/dio.dart';
import 'package:login_signin/core/data/cart_model.dart';

class ApiService {
  final Dio _dio = Dio();

  ApiService() {
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        error: true,
      ),
    );
  }
  Future<Response> get({required String path}) async {
    try {
      return await _dio.get(path);
    } on DioException catch (e) {
      throw e.message ?? "Something went wrong";
    }
  }
}

void main() async {
  final apiService = ApiService();

  try {
    // Example GET request
    print('Fetching ...');
    final response = await apiService.get(
      //path: 'https://fakerestaurantapi.runasp.net/api/User',
      path:
          "https://fakerestaurantapi.runasp.net/api/Order?apikey=536e2ff9-56e6-4f61-989f-98280c836195",
    );
    print('Response data: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }

  try {
    // Example GET request
    print('Fetching ...');
    final response = await apiService.get(
      path: 'https://fakerestaurantapi.runasp.net/api/User',
    );
    print('Response data: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }
}
