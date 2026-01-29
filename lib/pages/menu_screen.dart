import 'package:flutter/material.dart';
import 'package:pp8banjaran/pages/Riwayat/riwayat_screen.dart';
import 'package:pp8banjaran/pages/home_screen.dart';
import 'package:pp8banjaran/pages/home_screen2.dart';
import 'package:pp8banjaran/pages/pengumuman/pengumuman_screen.dart';
import 'package:pp8banjaran/pages/profile/profile_page.dart';
import 'package:pp8banjaran/pages/kegiatan/kegiatan_screen.dart';
import 'package:pp8banjaran/pages/saran/saran_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardScreen(),
    RiwayatScreen(),
    KegiatanScreen(),
    PengumumanScreen(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Biar background transparan jalan
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) => setState(() => _currentIndex = index),
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey[400],
            backgroundColor: Colors.black.withOpacity(0.8),
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
            ),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.history_rounded),
                label: 'Riwayat',
              ),
              
              BottomNavigationBarItem(
                icon: Icon(Icons.event_rounded),
                label: 'Kegiatan',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.announcement_rounded),
                label: 'Pengumuman',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
