import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class MidtransScreen extends StatelessWidget {
  const MidtransScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final snapToken = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse(
              'https://app.sandbox.midtrans.com/snap/v2/vtweb/$snapToken',
            ),
          ),
      ),
    );
  }
}
