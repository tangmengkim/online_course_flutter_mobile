import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constraints/constraint.dart';

class ApiService {
  final String _BASEURL = kBaseUrl;

  Future<http.Response> get(String endpoint, {String? token}) async {
    return await http.get(
      Uri.parse('$_BASEURL/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> data,
      {String? token}) async {
    return await http.post(
      Uri.parse('$_BASEURL/$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
  }
}
