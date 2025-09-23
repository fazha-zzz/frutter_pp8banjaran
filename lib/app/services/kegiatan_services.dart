import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pp8banjaran/app/data/model/kegiatan.dart';


class KegiatanService {
  static const String baseUrl = "http://ipl-pp8banjaran.web.id/api";
  // 👉 ganti dengan domain hosting Laravel Tuan

  Future<KegiatanModel?> getKegiatan({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/kegiatan?page=$page"),
        headers: {"Accept": "application/json"},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return KegiatanModel.fromJson(jsonData);
      } else {
        throw Exception("Gagal load kegiatan, code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error getKegiatan: $e");
      return null;
    }
  }
}
