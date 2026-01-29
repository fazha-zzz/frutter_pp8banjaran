import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'saran_controller.dart';

class SaranScreen extends StatelessWidget {
  SaranScreen({super.key});

  final controller = Get.put(SaranController());
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeef6fb),
      appBar: AppBar(title: const Text('Kritik & Saran'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// ===== FORM =====
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Tulis Kritik atau Saran',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: textController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Ketik pesan di sini...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (textController.text.isEmpty) return;

                          await controller.kirim(textController.text);
                          textController.clear();

                          Get.snackbar(
                            'Berhasil',
                            'Kritik & saran berhasil dikirim',
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                          );
                        },
                        child: const Text('Kirim'),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ===== RIWAYAT =====
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Riwayat Kritik & Saran Anda',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 12),

            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.saranList.isEmpty) {
                  return const Center(
                    child: Text('Belum ada kritik atau saran'),
                  );
                }

                return ListView.builder(
                  itemCount: controller.saranList.length,
                  itemBuilder: (context, index) {
                    final item = controller.saranList[index];

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.isi),
                            const SizedBox(height: 8),
                            Text(
                              DateFormat(
                                'dd MMM yyyy HH:mm',
                              ).format(item.createdAt),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
