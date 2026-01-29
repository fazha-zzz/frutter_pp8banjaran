import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../pages/kegiatan/kegiatan_controller.dart';
import 'kegiatan_detail_screen.dart';

class KegiatanScreen extends StatelessWidget {
  KegiatanScreen({super.key});

  final controller = Get.put(KegiatanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF3FAFF), Color(0xFFEFF6FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),

              /// ===== HEADER (SAMA DENGAN PENGUMUMAN) =====
              Column(
                children: [
                  Text(
                    'Kegiatan Warga',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                          colors: [Color(0xFF4F7CFF), Color(0xFF3BAE8C)],
                        ).createShader(const Rect.fromLTWH(0, 0, 300, 70)),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Berikut adalah kegiatan warga yang akan dan telah dilaksanakan.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 40),

              /// ===== LIST =====
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.kegiatanList.isEmpty) {
                    return const Center(child: Text('Belum ada kegiatan'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.kegiatanList.length,
                    itemBuilder: (context, index) {
                      final item = controller.kegiatanList[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// ===== GARIS ATAS =====
                            Container(
                              height: 5,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF4F7CFF),
                                    Color(0xFF8B5CF6),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// ===== TANGGAL =====
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F5FF),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(
                                            Icons.calendar_today,
                                            size: 14,
                                            color: Color(0xFF4F7CFF),
                                          ),
                                          const SizedBox(width: 6),
                                          Text(
                                            item.tanggal != null
                                                ? DateFormat(
                                                    'dd MMM yyyy',
                                                    'id_ID',
                                                  ).format(item.tanggal!)
                                                : '-',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  /// ===== JUDUL =====
                                  Text(
                                    item.namaKegiatan ?? '-',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  /// ===== LOKASI =====
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        size: 16,
                                        color: Colors.black54,
                                      ),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          item.lokasi ?? '-',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 16),

                                  /// ===== FOOTER =====
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Get.to(
                                            () => KegiatanDetailScreen(
                                              id: item.id!,
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Lihat Detail →',
                                          style: TextStyle(
                                            fontSize: 15, // ⬅️ diperbesar
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF4F7CFF),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
