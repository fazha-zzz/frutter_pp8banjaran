import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pp8banjaran/model/pengumuman.dart';
import 'package:get_storage/get_storage.dart';

class PengumumanService {
  final box = GetStorage();
  final String baseUrl = 'http://127.0.0.1:8000/api';

  /// =============================
  /// GET LIST PENGUMUMAN
  /// =============================
  Future<PengumumanModel?> fetchPengumuman() async {
    try {
      final token = box.read('token');

      print('TOKEN RIWAYAT: $token');
      
      final response = await http.get(
        Uri.parse('$baseUrl/pengumuman'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return PengumumanModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('ERROR GET PENGUMUMAN: $e');
    }
    return null;
  }

  /// =============================
  /// GET DETAIL PENGUMUMAN
  /// =============================
  Future<Pengumuman?> fetchPengumumanDetail(int id) async {
    try {
      final token = box.read('token');

      final response = await http.get(
        Uri.parse('$baseUrl/pengumuman/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Pengumuman.fromJson(json['data']);
      }
    } catch (e) {
      print('ERROR DETAIL PENGUMUMAN: $e');
    }
    return null;
  }
}
