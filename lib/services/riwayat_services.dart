import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../model/riwayat.dart';

class RiwayatServices {
  static const baseUrl = 'https://abstruse-terica-discordant.ngrok-free.dev/api';

  static Future<Map<String, dynamic>> fetchPembayaran() async {
    final token = GetStorage().read('token');

    final response = await http.get(
      Uri.parse('$baseUrl/user/pembayaran'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat pembayaran');
    }
  }
}
