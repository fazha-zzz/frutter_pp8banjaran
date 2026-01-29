import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../model/kegiatan.dart';

class KegiatanService {
  final box = GetStorage();
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<KegiatanModel?> fetchKegiatan() async {
    final token = box.read('token');

    final response = await http.get(
      Uri.parse('$baseUrl/kegiatan'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );



    if (response.statusCode == 200) {
      return KegiatanModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  Future<Kegiatan?> fetchDetail(int id) async {
    final token = box.read('token');

    final response = await http.get(
      Uri.parse('$baseUrl/kegiatan/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );


    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Kegiatan.fromJson(json['data']);
    }
    return null;
  }
}
