import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../pages/Riwayat/riwayat_controller.dart';
import '../../services/midtrans_service.dart';
import 'package:pp8banjaran/pages/custom_header.dart';
import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class RiwayatScreen extends StatelessWidget {
  RiwayatScreen({super.key});

  Color statusColor(String status) {
    if (status == 'berhasil dibayar') return Colors.green;
    if (status == 'menunggu pembayaran') return Colors.orange;
    return Colors.red;
  }

  String statusText(String status) {
    if (status == 'berhasil dibayar') return 'berhasil dibayar';
    if (status == 'menunggu pembayaran') return 'Menunggu Pembayaran';
    return 'Belum Terbayar';
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RiwayatController());

    return Scaffold(
      appBar: const CustomHeader(),
      backgroundColor: const Color(0xfff5f7fb),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Debug log
        print('Tunggakan: ${controller.tunggakan.length}');
        print('Histori: ${controller.histori.length}');

        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ===================== BAYAR SEMUA =====================
            if (controller.tunggakan.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton.icon(
                 onPressed: () async {
                    try {
                      final snap = await MidtransService.bayarSemua();

                      if (kIsWeb) {
                        js.context.callMethod('payMidtrans', [snap.snapToken]);
                      } else {
                        Get.snackbar(
                          'Info',
                          'Pembayaran hanya tersedia di Web',
                        );
                      }
                    } catch (e) {
                      Get.snackbar(
                        'Error',
                        e.toString(),
                        backgroundColor: Colors.redAccent,
                        colorText: Colors.white,
                      );
                    }
                  },
                  icon: const Icon(Icons.payment),
                  label: Text(
                    'Bayar Semua (${controller.tunggakan.length} Tagihan)',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),

            // ===================== TUNGGAKAN =====================
            if (controller.tunggakan.isEmpty)
              const Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Tidak ada tunggakan 🎉',
                  style: TextStyle(color: Colors.black54),
                ),
              )
            else
              ...controller.tunggakan.map((item) => _buildItem(item)),

            const SizedBox(height: 20),

            // ===================== HISTORI =====================
            const Text(
              'Histori Pembayaran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),

            if (controller.histori.isEmpty)
              const Text(
                'Belum ada histori pembayaran',
                style: TextStyle(color: Colors.black54),
              )
            else
              ...controller.histori.map((item) => _buildItem(item)),
          ],
        );
      }),
    );
  }

  Widget _buildItem(item) {
    final totalFinal = item.total + (item.denda ?? 0);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // ICON / IMAGE
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: const DecorationImage(
                  image: AssetImage('assets/images/pesona1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 14),
            // DETAIL TRANSAKSI
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('dd MMMM yyyy').format(item.tanggal),
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${NumberFormat('#,###', 'id_ID').format(totalFinal)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    statusText(item.status),
                    style: TextStyle(
                      fontSize: 13,
                      color: statusColor(item.status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            // NOMINAL IDR (KANAN)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'IDR',
                  style: TextStyle(fontSize: 12, color: Colors.black45),
                ),
                const SizedBox(height: 4),
                Text(
                  'Rp ${NumberFormat('#,###', 'id_ID').format(totalFinal)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
