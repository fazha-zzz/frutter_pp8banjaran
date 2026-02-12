import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:pp8banjaran/pages/auth/login_screen.dart';

class AuthMiddleware extends GetMiddleware {
  final box = GetStorage();

  @override
  RouteSettings? redirect(String? route) {
    final token = box.read('token');

    if (token == null || token.toString().isEmpty) {
      return const RouteSettings(name: '/login');
    }

    return null; // lanjut ke halaman yang dituju
  }
}
