import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../model/riwayat.dart';

class RiwayatServices {
  static const baseUrl = 'http://127.0.0.1:8000/api';

  static Future<List<RiwayatModel>> fetchRiwayat() async {
    final token = GetStorage().read('token');

    final response = await http.get(
      Uri.parse('$baseUrl/pembayaran/riwayat'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List data = body['data'];

      return data.map((e) => RiwayatModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal memuat riwayat');
    }
  }
}
