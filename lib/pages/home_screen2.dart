import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pp8banjaran/pages/custom_header.dart';
import 'package:pp8banjaran/pages/iklan/iklan_carousel.dart';
import '../services/dashboart_services.dart';
import '../services/midtrans_service.dart';
import '../services/iklan_services.dart';
import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomHeader(),
      backgroundColor: const Color(0xFFF3FAFF),
      body: SafeArea(
        child: FutureBuilder(
          future: DashboardService.fetchDashboard(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('Gagal memuat data'));
            }

            final data = snapshot.data!;
            final tagihan = data.tagihan;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// ===== HEADER =====
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF4F7CFF).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Color(0xFF4F7CFF),
                      child: Icon(Icons.person, color: Colors.white, size: 32),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Selamat Datang',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                  const Text(
                    'Warga Pesona Prima 8',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF4F7CFF),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ===== TAGIHAN CARD =====
                  FutureBuilder(
                    future: tagihan != null
                        ? MidtransService.getSnapToken(tagihan['id'])
                        : Future.value(null),
                    builder: (context, snapshot) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF4F7CFF), Color(0xFF3BAE8C)],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Detail Tagihan
                            if (snapshot.hasData)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Tagihan',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              'Rp ${snapshot.data!.total ?? 0}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Denda',
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              'Rp ${snapshot.data!.denda ?? 0}',
                                              style: const TextStyle(
                                                color: Color(0xFFFFB6B6),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        Container(
                                          height: 1,
                                          color: Colors.white.withOpacity(0.3),
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Total Bayar',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              'Rp ${snapshot.data!.totalFinal ?? 0}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              )
                            else if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const SizedBox(
                                  height: 80,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            else
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Tagihan',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Rp ${tagihan != null ? tagihan['total'] : 0}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),

                            /// Tombol Bayar
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF4F7CFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                                onPressed:
                                    tagihan == null ||
                                        snapshot.connectionState ==
                                            ConnectionState.waiting
                                    ? null
                                    : () async {
                                        try {
                                          final snapToken =
                                              await MidtransService.getSnapToken(
                                                tagihan['id'],
                                              );

                                          if (kIsWeb) {
                                            js.context.callMethod(
                                              'payMidtrans',
                                              [snapToken.snapToken],
                                            );
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
                                child: const Text(
                                  'Bayar Sekarang',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  const SizedBox(height: 20),

                  /// ===== IKLAN CAROUSEL =====
                  FutureBuilder(
                    future: IklanService.fetchIklans(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 240,
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }

                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const SizedBox();
                      }

                      print('IKLAN DATA: ${snapshot.data}');

                      return SizedBox(
                        height: 250,
                        child: IklanCarousel(iklans: snapshot.data!),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  /// ===== MENU =====
                  const Text(
                    'Info & Layanan',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4F7CFF),
                    ),
                  ),
                  const SizedBox(height: 12),

                  GridView.count(
                    crossAxisCount: 5,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    children: [
                      _menuItem(Icons.campaign, 'Pengumuman', '/pengumuman'),
                      _menuItem(Icons.event, 'Kegiatan', '/kegiatan'),
                      _menuItem(Icons.feedback, 'Saran', '/saran'),
                      _menuItem(Icons.history, 'Riwayat', '/riwayat'),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, String route) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFEFF6FF),
              child: Icon(icon, color: const Color(0xFF4F7CFF), size: 24),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
