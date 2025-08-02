import 'package:login_signin/core/remote/api_keys.dart';

class Auth {
  final String username;
  final String password;
  const Auth({required this.username, required this.password});

  Map<String, dynamic> tologinJson() => {
    ApiKeys.password: password,
    ApiKeys.username: username,
  };
}
