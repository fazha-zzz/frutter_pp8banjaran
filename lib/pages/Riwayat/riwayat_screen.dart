import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../pages/Riwayat/riwayat_controller.dart';
import 'package:pp8banjaran/pages/custom_header.dart';

class RiwayatScreen extends StatelessWidget {
  RiwayatScreen({super.key});

  final controller = Get.put(RiwayatController());

  Color statusColor(String status) {
    if (status == 'pembayaran berhasil') return Colors.green;
    if (status == 'menunggu pembayaran') return Colors.orange;
    return Colors.red;
  }

  String statusText(String status) {
    if (status == 'pembayaran berhasil') return 'Pembayaran Berhasil';
    if (status == 'menunggu pembayaran') return 'Menunggu Pembayaran';
    return 'Belum Terbayar';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(),
      backgroundColor: const Color(0xfff5f7fb),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.riwayatList.isEmpty) {
          return const Center(child: Text('Belum ada riwayat pembayaran'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.riwayatList.length,
          itemBuilder: (context, index) {
            final item = controller.riwayatList[index];

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
                    /// ICON / IMAGE
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

                    /// DETAIL TRANSAKSI
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('dd MMMM yyyy').format(item.tanggal),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Rp ${NumberFormat('#,###', 'id_ID').format(item.total)}',
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

                    /// NOMINAL IDR (KANAN)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'IDR',
                          style: TextStyle(fontSize: 12, color: Colors.black45),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp ${NumberFormat('#,###', 'id_ID').format(item.total)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
