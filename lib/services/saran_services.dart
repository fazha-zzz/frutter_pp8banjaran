import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pp8banjaran/model/saran.dart';


class SaranService {
  final String baseUrl =
      "http://127.0.0.1:8000/api"; // sesuaikan dengan API Tuan

  /// Ambil semua saran
  Future<SaranModel?> getAllSaran() async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/saran"));
      if (response.statusCode == 200) {
        return SaranModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("Error getAllSaran: $e");
    }
    return null;
  }

  /// Tambah saran baru
  Future<bool> createSaran(int idUser, String isi) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/saran"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id_user": idUser, "isi": isi}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      print("Error createSaran: $e");
    }
    return false;
  }
}
