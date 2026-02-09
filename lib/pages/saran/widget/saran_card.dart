import 'package:flutter/material.dart';
import '../../../model/saran.dart';
import 'package:url_launcher/url_launcher.dart';

class SaranCard extends StatelessWidget {
  final Saran item;
  const SaranCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.isi),
            const SizedBox(height: 6),
            Text(
              item.createdAt.toString(),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),

            /// LAMPIRAN USER
            if (item.userFiles.isNotEmpty == true) ...[
              const Divider(),
              const Text('Lampiran:'),
              ...item.userFiles.map(
                (f) => TextButton(
                  onPressed: () => launchUrl(Uri.parse(f.fullUrl)),
                  child: Text(f.fileName),
                ),
              ),
            ],

            /// BALASAN ADMIN
            if (item.balasan != null) ...[
              const Divider(),
              const Text(
                'Balasan Admin:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              Text(item.balasan!),
            ],

            /// LAMPIRAN ADMIN
            if (item.adminFiles.isNotEmpty) ...[
              const SizedBox(height: 4),
              ...item.adminFiles.map(
                (f) => TextButton(
                  onPressed: () => launchUrl(Uri.parse(f.fullUrl)),
                  child: Text(f.fileName),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
