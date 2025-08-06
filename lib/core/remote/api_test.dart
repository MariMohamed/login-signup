import 'package:login_signin/core/remote/api_constants.dart';
import 'package:login_signin/core/remote/api_service.dart';

void main() async {
  final apiService = ApiService();

  try {
    // Example GET request
    print('Fetching ...');
    final response = await apiService.get(path: "${ApiConstants.users}/10");
    print('Response data: ${response.data}');
  } catch (e) {
    print('Error: $e');
  }
}
