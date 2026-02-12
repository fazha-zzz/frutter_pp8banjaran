import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../model/riwayat.dart';

class RiwayatServices {
  static const baseUrl =
      'https://abstruse-terica-discordant.ngrok-free.dev/api';

  /// Ambil data pembayaran user
  static Future<Map<String, dynamic>> fetchPembayaran() async {
    final box = GetStorage();
    final token = box.read('token');

    if (token == null) {
      throw Exception('Token belum tersimpan! Pastikan login dulu.');
    }

    print('🔑 Token yang digunakan di fetchPembayaran(): $token');

    final response = await http.get(
      Uri.parse('$baseUrl/pembayaran'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json','ngrok-skip-browser-warning': 'true',},
    );

    print('📡 Response status: ${response.statusCode}');
    print('📄 Response body history: ${response.body}');

    if (response.statusCode == 200) {
      final raw = json.decode(response.body);
      final data = raw['data']; // ambil data dari key 'data'
      return data;
    } else {
      throw Exception('Gagal memuat pembayaran');
    }
  }
}
