import 'package:flutter/material.dart';
import 'package:pp8banjaran/pages/Riwayat/riwayat_screen.dart';
import 'package:pp8banjaran/pages/auth/login_screen.dart';
import 'package:pp8banjaran/pages/menu_screen.dart';
import 'package:pp8banjaran/pages/saran/saran_screen.dart';
import 'package:pp8banjaran/services/auth_services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('id_ID', null);
  await GetStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PP8 Banjaran',

      initialRoute: '/',

      getPages: [
        GetPage(name: '/', page: () => const AuthCheck()),
        GetPage(name: '/login', page: () => const LoginScreen()),
        GetPage(name: '/menu', page: () => const MenuScreen()),
        GetPage(name: '/saran', page: () => SaranPage()),
      ],
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(milliseconds: 300));
    final isLoggedIn = await _authService.isLoggedIn();

    if (!mounted) return;

    if (isLoggedIn) {
      Get.offAllNamed('/menu');
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
