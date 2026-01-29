import 'dart:convert';
import 'package:http/http.dart' as http;
import 'auth_services.dart';

class MidtransService {
  static const String baseUrl =
      'https://abstruse-terica-discordant.ngrok-free.dev/api';

  static Future<String> getSnapToken(int tagihanId) async {
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

    print('MIDTRANS STATUS: ${response.statusCode}');
    print('MIDTRANS BODY: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Gagal membuat snap token');
    }

    final json = jsonDecode(response.body);

    final snapToken = json['data']?['snap_token'];

    if (snapToken == null || snapToken.toString().isEmpty) {
      throw Exception('Snap token kosong');
    }

    return snapToken;
  }

}
