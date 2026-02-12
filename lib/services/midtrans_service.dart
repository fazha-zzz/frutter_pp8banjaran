import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_services.dart';
import '../model/midtrans_token_model.dart';

class MidtransService {
  static const String baseUrl =
      'https://abstruse-terica-discordant.ngrok-free.dev/api';

  static Future<MidtransTokenModel> getSnapToken(int tagihanId) async {
    final token = await AuthService.getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/midtrans/token'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'tagihan_id': tagihanId}),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal membuat snap token');
    }

    final json = jsonDecode(response.body);
    return MidtransTokenModel.fromJson(json);
  }

  // bayar semua
  static Future<MidtransTokenModel> bayarSemua() async {
    final token = await AuthService.getToken();

    final response = await http.post(
      Uri.parse('$baseUrl/midtrans/bayar-semua'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      final msg = jsonDecode(response.body)['message'] ?? 'Gagal bayar semua';
      throw Exception(msg);
    }

    final jsonData = jsonDecode(response.body);
    return MidtransTokenModel.fromJson(jsonData);
  }

}
