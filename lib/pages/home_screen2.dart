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

  // Fungsi helper untuk mengambil semua data sekaligus agar tidak banyak FutureBuilder
  Future<Map<String, dynamic>> _loadAllData() async {
    final dashboardData = await DashboardService.fetchDashboard();
    final iklanData = await IklanService.fetchIklans();
    return {'dashboard': dashboardData, 'iklans': iklanData};
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4F7CFF);
    const secondaryColor = Color(0xFF3BAE8C);

    return Scaffold(
      appBar: const CustomHeader(),
      backgroundColor: const Color(0xFFF8FBFF), // Warna lebih soft
      body: SafeArea(
        child: FutureBuilder<Map<String, dynamic>>(
          future: _loadAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: primaryColor),
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return _buildErrorState();
            }

            final data = snapshot.data!['dashboard'];
            final iklans = snapshot.data!['iklans'];
            final tagihan = data?.tagihan;

            return RefreshIndicator(
              onRefresh: () async => Get.offNamed('/dashboard'), // Simple refresh
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ===== USER GREETING =====
                    _buildGreeting(primaryColor),

                    const SizedBox(height: 25),

                    /// ===== TAGIHAN CARD (VIP LOOK) =====
                    _buildTagihanCard(
                      context,
                      tagihan,
                      primaryColor,
                      secondaryColor,
                    ),

                    const SizedBox(height: 30),

                    /// ===== IKLAN CAROUSEL =====
                    if (iklans != null && iklans.isNotEmpty) ...[
                      const Text(
                        'Promo & Informasi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 200,
                        child: IklanCarousel(iklans: iklans),
                      ),
                      const SizedBox(height: 30),
                    ],

                    /// ===== MENU GRID =====
                    const Text(
                      'Layanan Warga',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    GridView.count(
                      crossAxisCount: 4, // 4 Kolom lebih pas untuk mobile
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                      children: [
                        _menuItem(Icons.campaign, 'Pengumuman', '/pengumuman'),
                        _menuItem(Icons.event, 'Kegiatan', '/kegiatan'),
                        _menuItem(Icons.feedback, 'Saran', '/saran'),
                        _menuItem(Icons.history, 'Riwayat', '/riwayat'),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGreeting(Color primaryColor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: primaryColor, width: 2),
          ),
          child: const CircleAvatar(
            radius: 28,
            backgroundColor: Color(0xFFE0E7FF),
            child: Icon(
              Icons.person_rounded,
              color: Color(0xFF4F7CFF),
              size: 30,
            ),
          ),
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Halo, Selamat Datang',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              'Warga Pesona Prima 8',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: primaryColor.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTagihanCard(
    BuildContext context,
    dynamic tagihan,
    Color primary,
    Color secondary,
  ) {
    bool hasTagihan = tagihan != null && (tagihan['total'] ?? 0) > 0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: hasTagihan
              ? [primary, secondary]
              : [Colors.blueGrey, Colors.grey],
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Tagihan Anda',
            style: TextStyle(color: Colors.white60, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            hasTagihan ? 'Rp ${tagihan['total']}' : 'Tidak Ada Tagihan',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          if (hasTagihan)
            ElevatedButton(
              onPressed: () => _handlePayment(tagihan['id']),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: const Text(
                'BAYAR SEKARANG',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, String route) {
    return InkWell(
      onTap: () => Get.toNamed(route),
      child: Column(
        mainAxisSize:
            MainAxisSize.min, // Biarkan kolom mengambil ruang sekecil mungkin
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Wadah Ikon
          Container(
            padding: const EdgeInsets.all(10), // Padding dalam
            decoration: BoxDecoration(
              color: const Color(0xFF4F7CFF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: const Color(0xFF4F7CFF), size: 28),
          ),
          const SizedBox(height: 8),
          // Teks Menu
          Text(
            label,
            maxLines: 1, // Batasi 1 baris agar tidak overflow ke bawah
            overflow: TextOverflow.ellipsis, // Jika kepanjangan jadi "..."
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _handlePayment(var tagihanId) async {
    try {
      final snapData = await MidtransService.getSnapToken(tagihanId);
      if (kIsWeb) {
        js.context.callMethod('payMidtrans', [snapData.snapToken]);
      } else {
        Get.snackbar(
          'Info',
          'Pembayaran via App sedang disiapkan. Gunakan versi Web.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memproses pembayaran',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
          const SizedBox(height: 16),
          const Text('Gagal memuat data dashboard'),
          TextButton(
            onPressed: () => Get.offNamed('/dashboard'),
            child: const Text('Coba Lagi'),
          ),
        ],
      ),
    );
  }
}

extension ColorsWhiteExtension on Colors {
  static const Color whiteB60 = Color(0xB3FFFFFF);
}
