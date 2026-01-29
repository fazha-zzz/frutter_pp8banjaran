import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class AuthService {
  final box = GetStorage();
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<bool> login({
    required String noRumah,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'no_rumah': noRumah, 'password': password}),
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      box.write('token', data['token']);
      return true;
    }
    return false;
  }

  Future<bool> isLoggedIn() async {
    final token = box.read('token');
    return token != null && token.toString().isNotEmpty;
  }

  Future<void> logout() async {
    await box.remove('token');
  }

  static Future<String?> getToken() async {
    final box = GetStorage();
    final token = box.read('token');

    if (token == null || token.toString().isEmpty) {
      return null;
    }

    return token.toString();
  }

    
}

