import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_services.dart';
import '../model/dasboard.dart';

class DashboardService {
  static const baseUrl = 'http://127.0.0.1:8000/api';

  static Future<DashboardModel> fetchDashboard() async {
    final token = await AuthService.getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/dashboard'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return DashboardModel.fromJson(body['data']);
    } else {
      throw Exception('Gagal memuat dashboard');
    }
  }
}
