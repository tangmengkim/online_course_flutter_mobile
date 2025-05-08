import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SharedPreferencesStorage {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString('jwt_token', token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('jwt_token');
  }

  static Future<void> deleteToken() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.remove('jwt_token');
  }

  static Future<bool> isTokenExpired() async {
    String? token = await getToken();
    if (token == null) return true; // No token means expired
    return JwtDecoder.isExpired(token);
  }

  static Future<String?> getValidToken() async {
    bool isExpired = await SharedPreferencesStorage.isTokenExpired();

    if (isExpired) {
      return null; // Don't return expired token
    }
    return await SharedPreferencesStorage.getToken();
  }
}
