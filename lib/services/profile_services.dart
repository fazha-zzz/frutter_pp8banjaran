import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../model/profile.dart';

class ProfileService {
  final box = GetStorage();
  final String baseUrl = 'http://127.0.0.1:8000/api';

 Future<profileModel?> fetchProfile() async {
    final token = box.read('token');

    if (token == null) {
      print('❌ TOKEN NULL');
      return null;
    }

    final response = await http.get(
      Uri.parse('$baseUrl/my-profile'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    

    if (response.statusCode == 200) {
      return profileModel.fromJson(jsonDecode(response.body));
    }

    return null;
  }

}
