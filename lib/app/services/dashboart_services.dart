import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class PembayaranService {
  static const String baseUrl = "http://ipl-pp8banjaran.web.id/api";
  // 👉 ganti dengan domain hosting Laravel Tuan

  /// Create pembayaran (Dibayar)
  Future<bool> createPembayaran({
    required int idTagihan,
    required int rekeningId,
    File? buktiPembayaran,
  }) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/pembayaran"),
      );

      request.fields['id_tagihan'] = idTagihan.toString();
      request.fields['rekening_id'] = rekeningId.toString();

      if (buktiPembayaran != null) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'bukti_pembayaran',
            buktiPembayaran.path,
          ),
        );
      }

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print("Gagal create pembayaran, code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error createPembayaran: $e");
      return false;
    }
  }
}
