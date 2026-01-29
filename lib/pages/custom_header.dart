import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pp8banjaran/pages/saran/saran_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pp8banjaran/services/auth_services.dart';
import 'package:pp8banjaran/pages/auth/login_screen.dart';
class CustomHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 3,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            /// LOGO
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue, width: 2),
                image: const DecorationImage(
                  image: AssetImage('assets/images/pesona1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const Spacer(),

            /// TITLE
            const Text(
              'HOM',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),

            const Spacer(),

            /// NOTIFICATION
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.blue),
              onPressed: () {
                // TODO: buka modal notifikasi
              },
            ),

            /// MENU
           PopupMenuButton<String>(
            
              icon: const Icon(Icons.menu, color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onSelected: (value) async {
                if (value == 'iklan') {
                  final url = Uri.parse(
                    'https://wa.me/628815873744?text=Permisi%20Admin,%20saya%20mau%20pasang%20iklan',
                  );
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }

                if (value == 'saran') {
                  Get.to(() => SaranScreen());
                  // atau: Get.toNamed('/saran');
                }

                if (value == 'logout') {
                  await AuthService().logout();

                  Get.offAll(() => LoginScreen());
                  // ⬆️ offAll = tidak bisa back
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'iklan',
                  child: ListTile(
                    leading: Icon(Icons.image, color: Colors.blue),
                    title: Text('Pasang Iklan'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'saran',
                  child: ListTile(
                    leading: Icon(Icons.mail, color: Colors.green),
                    title: Text('Kritik & Saran'),
                  ),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.power_settings_new, color: Colors.red),
                    title: Text('Logout'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
