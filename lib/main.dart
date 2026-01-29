import 'package:flutter/material.dart';
import 'package:pp8banjaran/pages/Riwayat/riwayat_screen.dart';
import 'package:pp8banjaran/pages/auth/login_screen.dart';
import 'package:pp8banjaran/pages/menu_screen.dart';
import 'package:pp8banjaran/pages/saran/saran_screen.dart';
import 'package:pp8banjaran/services/auth_services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
void main() async{
 WidgetsFlutterBinding.ensureInitialized();
 await initializeDateFormatting('id_ID', null);
  await GetStorage.init(); // 🔥 WAJIB
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Belajar Flutter',
      home: AuthCheck(),
       getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/menu', page: () => MenuScreen()),
        GetPage(name: '/riwayat', page: () => RiwayatScreen()),
        GetPage(name: '/saran', page: () => SaranScreen()),
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
  late Future<bool> _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = _authService.isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          return MenuScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
