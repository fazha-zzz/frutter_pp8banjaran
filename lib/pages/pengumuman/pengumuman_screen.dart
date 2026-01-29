import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:pp8banjaran/pages/pengumuman/Pengumuman_detail_screen.dart';
import '../../pages/pengumuman/pengumuman_controller.dart';

class PengumumanScreen extends StatelessWidget {
  PengumumanScreen({super.key});

  final controller = Get.put(PengumumanController());

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

              /// ===== HEADER =====
              Column(
                children: [
                  Text(
                    'Pengumuman Penting',
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
                    'Berikut adalah pengumuman-pengumuman terbaru untuk Anda.',
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

                  if (controller.pengumumanList.isEmpty) {
                    return const Center(child: Text('Belum ada pengumuman'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.pengumumanList.length,
                    itemBuilder: (context, index) {
                      final item = controller.pengumumanList[index];

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
                            /// garis atas
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
                                  /// judul dan tanggal (satu baris) — judul kiri, tanggal kanan
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.judul ?? '-',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF1F5FF),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
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
                                    ],
                                  ),

                                  const SizedBox(height: 8),

                                  /// isi singkat
                                  Text(
                                    item.isi ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black54,
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  /// footer
                                  Row(
                                    children: [
                                      
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {
                                          Get.to(
                                            () => PengumumanDetailScreen(
                                              pengumuman: item,
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Baca Selengkapnya →',
                                          style: TextStyle(
                                            fontSize: 13,
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
