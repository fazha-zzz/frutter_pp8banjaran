import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import 'package:file_picker/file_picker.dart';
import '../model/saran.dart';

class SaranService {
  static const baseUrl = 'http://127.0.0.1:8000/api';

  /// ======================
  /// AMBIL DATA SARAN
  /// ======================
  static Future<List<Saran>> fetchSaran() async {
    final token = GetStorage().read('token');

    final res = await http.get(
      Uri.parse('$baseUrl/saran'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    if (res.statusCode != 200) {
      throw Exception('Gagal mengambil data saran');
    }

    final json = jsonDecode(res.body);
    final List list = json['data'];

    return list.map((e) => Saran.fromJson(e)).toList();
  }

  /// ======================
  /// KIRIM SARAN + FILE (WEB SAFE)
  /// ======================
  static Future<void> kirimSaran(String isi, List<PlatformFile> files) async {
    final token = GetStorage().read('token');

    final request = http.MultipartRequest('POST', Uri.parse('$baseUrl/saran'));

    request.headers['Authorization'] = 'Bearer $token';
    request.fields['isi'] = isi;

    for (final file in files) {
      if (file.bytes == null) continue;

      request.files.add(
        http.MultipartFile.fromBytes(
          'attachments[]',
          file.bytes!,
          filename: file.name,
        ),
      );
    }

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Gagal mengirim saran');
    }
  }
}
