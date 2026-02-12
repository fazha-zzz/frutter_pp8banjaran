import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';

class GuestMiddleware extends GetMiddleware {
  final box = GetStorage();

  @override
  RouteSettings? redirect(String? route) {
    final token = box.read('token');

    if (token != null && token.toString().isNotEmpty) {
      return const RouteSettings(name: '/menu');
    }

    return null;
  }
}
