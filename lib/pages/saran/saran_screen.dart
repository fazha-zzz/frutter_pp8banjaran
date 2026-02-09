import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'saran_controller.dart';
import 'widget/saran_card.dart';

class SaranPage extends StatelessWidget {
  SaranPage({super.key});

  final controller = Get.put(SaranController());
  final isiCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kritik & Saran')),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// FORM
                    TextField(
                      controller: isiCtrl,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan di sini...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    OutlinedButton.icon(
                      onPressed: controller.pickFiles,
                      icon: const Icon(Icons.attach_file),
                      label: const Text('Lampiran File'),
                    ),

                    Obx(
                      () => controller.files.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Wrap(
                                spacing: 6,
                                children: controller.files
                                    .map(
                                      (f) => Chip(
                                        label: Text(
                                           f.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            )
                          : const SizedBox(),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await controller.kirimSaran(isiCtrl.text);
                          isiCtrl.clear();
                        },
                        child: const Text('Kirim'),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// RIWAYAT
                    const Text(
                      'Riwayat Kritik & Saran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Obx(
                      () => controller.list.isEmpty
                          ? const Text(
                              'Belum ada kritik atau saran',
                              style: TextStyle(color: Colors.grey),
                            )
                          : Column(
                              children: controller.list
                                  .map((e) => SaranCard(item: e))
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
