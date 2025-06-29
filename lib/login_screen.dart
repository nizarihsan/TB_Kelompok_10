import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'api_service.dart';
import 'home_screen.dart';
import 'register_screen.dart'; // Pastikan path sudah benar
import 'onboarding_screen.dart'; // Pastikan path sudah benar

// Bagian 1: Definisi Tema Aplikasi
// Warna-warna ini diambil dari variabel root CSS.
class AppTheme {
  static const Color primaryColor = Color(0xFF0C7FF2);
  static const Color secondaryColor = Color(0xFFE7EDF4);
  static const Color textPrimary = Color(0xFF0D141C);
  static const Color textSecondary = Color(0xFF49739C);
  static const Color backgroundColor = Color(0xFFF8FAFC);
}

// Bagian 2: Widget Utama Halaman Login
// StatelessWidget cocok di sini karena tidak ada state yang perlu dikelola.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  String? error;
  bool _obscurePassword = true; // Tambahkan ini

  Future<void> handleLogin() async {
    setState(() {
      isLoading = true;
      error = null;
    });
    final result = await ApiService.login(
      email: emailController.text,
      password: passwordController.text,
    );
    setState(() {
      isLoading = false;
    });
    if (result['success'] == true) {
      // Berhasil login, akses token: result['data']['token']
      // Navigasi ke HomeScreen
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      setState(() {
        error = 'Login gagal. Email atau password salah.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FBFD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const OnboardingScreen()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Log in',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      // SafeArea memastikan UI tidak terhalang oleh notch atau status bar.
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32.0),
                    _buildHeader(),
                    const SizedBox(height: 32.0),
                    _buildForm(),
                  ],
                ),
              ),
            ),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  // Method untuk membangun judul "Welcome back"
  Widget _buildHeader() {
    return Text(
      'Welcome back',
      style: GoogleFonts.splineSans(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppTheme.textPrimary,
        letterSpacing: -0.015,
      ),
    );
  }

  // Method untuk membangun seluruh form login
  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input Email
        _buildTextField(
          controller: emailController,
          icon: Icons.mail_outline_rounded,
          hintText: 'Email',
          isEmail: true,
        ),
        const SizedBox(height: 24),
        // Input Password
        _buildTextField(
          controller: passwordController,
          icon: Icons.lock_outline_rounded,
          hintText: 'Password',
          isPassword: true,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off : Icons.visibility,
              color: AppTheme.textSecondary,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
        ),
        const SizedBox(height: 24),
        // Tombol Lupa Password
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {},
            child: Text(
              'Forgot password?',
              style: GoogleFonts.splineSans(
                color: AppTheme.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Pesan error
        if (error != null)
          Text(error!, style: const TextStyle(color: Colors.red)),
        // Tombol Login
        ElevatedButton(
          onPressed: isLoading ? null : handleLogin,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryColor,
            minimumSize: const Size(double.infinity, 56), // h-14
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 2.0,
            // ignore: deprecated_member_use
            shadowColor: AppTheme.primaryColor.withOpacity(0.3),
          ),
          child: isLoading
              ? const CircularProgressIndicator()
              : Text(
                  'Log in',
                  style: GoogleFonts.splineSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.015,
                  ),
                ),
        ),
      ],
    );
  }

  // Ubah _buildTextField agar menerima obscureText & suffixIcon
  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String hintText,
    bool isPassword = false,
    bool isEmail = false,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      style: GoogleFonts.splineSans(fontSize: 16, color: AppTheme.textPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.splineSans(color: AppTheme.textSecondary),
        prefixIcon: Icon(icon, color: AppTheme.textSecondary),
        filled: true,
        fillColor: AppTheme.secondaryColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2.0),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        suffixIcon: suffixIcon, // Tambahkan ini
      ),
    );
  }

  // Method untuk membangun footer dengan link "Sign up"
  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account? "),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              );
            },
            child: const Text(
              'Sign up',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}