import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/saran.dart';
import 'auth_services.dart';

class SaranService {
  static const baseUrl = 'http://127.0.0.1:8000/api/saran';

  static Future<List<SaranModel>> fetchSaran() async {
    final token = await AuthService.getToken();

    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }

    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return (body['data'] as List).map((e) => SaranModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat saran');
    }
  }

  static Future<void> kirimSaran(String isi) async {
    final token = await AuthService.getToken();

    if (token == null) {
      throw Exception('Token tidak ditemukan');
    }

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
      body: {'isi': isi},
    );

    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.body}');

    if (response.statusCode != 201) {
      throw Exception('Gagal mengirim saran');
    }
  }
}
