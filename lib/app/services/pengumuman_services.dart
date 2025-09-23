import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pp8banjaran/app/data/model/pengumuman.dart';


class PengumumanService {
  static const String baseUrl = "http://ipl-pp8banjaran.web.id/api";
  // 👉 ganti dengan domain hosting Laravel Tuan

  Future<PengumumanModel?> getPengumuman({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/pengumuman?page=$page"),
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return PengumumanModel.fromJson(jsonData);
      } else {
        throw Exception("Gagal load data, code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error getPengumuman: $e");
      return null;
    }
  }
}
