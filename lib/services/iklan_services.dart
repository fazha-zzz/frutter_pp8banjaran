import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/iklan.dart';
import 'package:get_storage/get_storage.dart';


class IklanService {
  static final box = GetStorage();
  static const baseUrl = 'http://127.0.0.1:8000/api';

  static Future<List<IklanModel>> fetchIklans() async {
    final token = box.read('token');

    final response = await http.get(
      Uri.parse('$baseUrl/iklan'),
       headers: {'Accept': 'application/json', 
       'Authorization': 'Bearer $token',
       },
      );

    print('IKLAN RAW RESPONSE: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Gagal memuat iklan');
    }

    final json = jsonDecode(response.body);
    final List list = json['data'];

    return list.map((e) => IklanModel.fromJson(e)).toList();
  }
}
