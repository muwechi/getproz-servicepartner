import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String keyIsLogin = "isLogin";
  static const String keyUserId = "user_id";
  static const String keyName = "user_fullname";
  static const String keyMobile = "user_phone";
  static const String keyEmail = "user_email";
  static const String keyImage = "user_image";

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLogin) ?? false;
  }

  static Future<void> createLoginSession({
    required String id,
    required String name,
    required String mobile,
    required String email,
    String? image,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLogin, true);
    await prefs.setString(keyUserId, id);
    await prefs.setString(keyName, name);
    await prefs.setString(keyMobile, mobile);
    await prefs.setString(keyEmail, email);
    if (image != null) {
      await prefs.setString(keyImage, image);
    }
  }

  static Future<Map<String, String>> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      "id": prefs.getString(keyUserId) ?? "",
      "name": prefs.getString(keyName) ?? "",
      "mobile": prefs.getString(keyMobile) ?? "",
      "email": prefs.getString(keyEmail) ?? "",
      "image": prefs.getString(keyImage) ?? "",
    };
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
