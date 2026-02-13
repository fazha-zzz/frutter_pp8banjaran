import 'package:flutter/material.dart';
import 'package:pp8banjaran/pages/menu_screen.dart';
import 'package:pp8banjaran/services/auth_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final TextEditingController noRumahController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    // Definisi Warna Utama agar Konsisten
    const primaryColor = Color(0xFF1E88E5);
    const accentColor = Color(0xFFE3F2FD);

    return Scaffold(
      backgroundColor: Colors.white, // Background bersih
      body: Container(
        // Menambahkan gradasi halus pada background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [accentColor, Colors.white],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  child: Column(
                    children: [
                      // ===== HEADER =====
                      Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.2),
                                  blurRadius: 20,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.home_work_rounded, // Icon lebih modern
                              size: 60,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            "Selamat Datang",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0D47A1),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Silahkan login untuk mengakses hunian Anda",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blueGrey[600],
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 40),

                      // ===== FORM LOGIN =====
                      // Menghilangkan container box putih agar lebih menyatu (Modern Design)
                      Column(
                        children: [
                          // No Rumah Input
                          _buildTextField(
                            controller: noRumahController,
                            label: 'No Rumah',
                            icon: Icons.house_rounded,
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 20),

                          // Password Input
                          _buildTextField(
                            controller: passwordController,
                            label: 'Password',
                            icon: Icons.lock_outline_rounded,
                            isPassword: true,
                            obscureText: _obscurePassword,
                            togglePassword: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Lupa Password (Opsional)
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text("Lupa Password?"),
                            ),
                          ),

                          const SizedBox(height: 30),

                          // Button Login dengan Shadow & Gradient
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: primaryColor.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: _handleLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 55),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                "LOGIN SEKARANG",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Refactor TextField untuk kode yang lebih bersih
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? togglePassword,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.blueGrey, fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xFF1E88E5)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: togglePassword,
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
        ),
      ),
    );
  }

  // Logika Login yang dipisah agar rapi
  Future<void> _handleLogin() async {
    if (noRumahController.text.isEmpty || passwordController.text.isEmpty) {
      _showSnackBar('No Rumah dan Password wajib diisi', Colors.redAccent);
      return;
    }

    // Tampilkan loading indicator jika perlu
    bool success = await _authService.login(
      noRumah: noRumahController.text,
      password: passwordController.text,
    );

    if (success) {
      if (!mounted) return;
      _showSnackBar('Selamat Datang!', Colors.green);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MenuScreen()),
      );
    } else {
      _showSnackBar('Login Gagal. Periksa kembali data Anda.', Colors.redAccent);
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}