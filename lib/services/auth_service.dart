import 'dart:convert';
import '../utils/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class AuthService {
  final ApiService _apiService;
  AuthService(this._apiService);

  Future<bool> login(String email, String password) async {
    try {
      http.Response response = await _apiService.post('auth/login', {
        'username': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        String token = responseBody['token'];
        await SharedPreferencesStorage.saveToken(token);
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      http.Response response = await _apiService.post('auth/register', {
        'username': email,
        'password': password,
      });
      print(response.headers);
      if (response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      throw Exception("Register failed: $e");
    }
  }

  Future<void> logout() async {
    try {
      await SharedPreferencesStorage.deleteToken();
    } catch (e) {
      throw Exception("Logout failed: $e");
    }
  }

  Future<bool> isAuthenticated() async {
    String? token = await SharedPreferencesStorage.getToken();
    print("isAuth");
    print(token);
    return token != null;
  }

  Future<String?> getToken() async {
    return await SharedPreferencesStorage.getToken();
  }

  Future<http.Response> getWithAuth(String endpoint) async {
    String? token = await getToken();
    return _apiService.get(endpoint, token: token);
  }

  Future<http.Response> postWithAuth(
      String endpoint, Map<String, dynamic> data) async {
    String? token = await getToken();
    return _apiService.post(endpoint, data, token: token);
  }
}
