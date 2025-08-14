import 'package:shared_preferences/shared_preferences.dart';

const String _isGuestKey = "IsGuest";
const String _tokenKey = "Token";
const String _userKey = 'current_user';

class SharedPreferencesManager {
  static late SharedPreferences _pref;
  static Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  static Future<void> setToken({required String token}) async {
    await _pref.setString(_tokenKey, token);
  }

  static String? getToken() {
    return _pref.getString(_tokenKey);
  }

  static Future<bool> removeToken() async {
    return await _pref.remove(_tokenKey);
  }

  static Future<void> setUser({
    required String username,
    required String password,
  }) async {
    await _pref.setStringList(_userKey, [username, password]);
  }

  static List<String>? getUser() {
    return _pref.getStringList(_userKey);
  }

  static Future<bool> removeUser() async {
    return await _pref.remove(_userKey);
  }

  // // Is Guest
  // static Future<void> setIsGuest({required bool isGuest}) async {
  //   await _pref.setBool(_isGuestKey, isGuest);
  // }

  // static bool? getIsGuest() {
  //   return _pref.getBool(_isGuestKey);
  // }

  // static Future<bool> removeIsGuest() async {
  //   return await _pref.remove(_isGuestKey);
  // }
}
