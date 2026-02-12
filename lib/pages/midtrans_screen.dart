import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'dart:js' as js;

class MidtransScreen extends StatelessWidget {
  const MidtransScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String snapToken = Get.arguments as String;

    // Auto open saat screen dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (kIsWeb) {
        js.context.callMethod('payMidtrans', [snapToken]);
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: const Center(
        child: Text(
          'Popup pembayaran Midtrans sedang dibuka…',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
