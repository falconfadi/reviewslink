import 'dart:convert';

import 'package:reviews_link_v2/data/models/response/auth/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static Future saveUserToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userToken', token);
  }

  static Future getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('userToken') ?? "";
    return token;
  }

  static Future deleteUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userToken');
  }

  static Future saveLang(String lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('lang', lang);
  }

  static Future getLang() async {
    final prefs = await SharedPreferences.getInstance();
    String lang = prefs.getString('lang') ?? "";
    return lang;
  }

  static Future saveFCMToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('fcmToken', token);
  }

  static Future getFCMToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('fcmToken') ?? "";
    return token;
  }

  static Future deleteFCMToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('fcmToken');
  }

  static Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('userData', userJson);
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('userData');

    if (userJson == null) return null;

    Map<String, dynamic> userMap = jsonDecode(userJson);
    return User.fromJson(userMap);
  }

  static Future<void> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
  }
}
