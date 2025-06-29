import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login_screen.dart'; // Pastikan path sudah benar

// Bagian 1: Definisi Tema Aplikasi
// Warna-warna ini diambil dari variabel root CSS.
class AppTheme {
  static const Color primaryColor = Color(0xFF0C7FF2);
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color backgroundColor = Color(0xFFF9FAFB); // slate-50
  static const Color buttonTextColor = Color(0xFFF9FAFB); // slate-50
}

// Bagian 2: Widget Utama Halaman Onboarding
// StatelessWidget cocok di sini karena halaman ini tidak memiliki state.
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar untuk layout yang responsif
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        top: false, // Memungkinkan gambar memenuhi bagian atas layar
        child: Column(
          children: [
            // Bagian 1: Gambar Atas
            _buildTopImage(height: screenHeight * 0.5), // Mengambil 50% tinggi layar

            // Bagian 2: Konten Teks di Tengah (mengisi ruang yang tersisa)
            Expanded(
              child: _buildTextContent(),
            ),

            // Bagian 3: Tombol Aksi di Bawah
            _buildBottomButton(context),
          ],
        ),
      ),
    );
  }

  // Widget untuk gambar di bagian atas
  Widget _buildTopImage({required double height}) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuDxf0rvazCUch1uNY82WO0mXgbcueqdaATHSFSAEXH7ePMF1gQTaaYadk_jfdKlf0JG6v2hFHBzci6pKeGB_zBnpkmmCvkFwcB5lH0XjSiUyFdtktbkgUNIESLz5n1omTayBBj4j4Ui3n5b2JG9ehRVAX9vNvqfvZ769qg7YgG0aYhclSQcGinitN_PCJZDr8c-gjYiObvSRnwzdD2DBCl6RDhmvkYESjbRkjaJ-XD-p7Nsd1fb5BwWjzKVM8C818qpyPiDLbfbjvAP"),
          fit: BoxFit.cover, // Meniru 'bg-cover'
        ),
      ),
    );
  }

  // Widget untuk konten teks
  Widget _buildTextContent() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Memusatkan teks secara vertikal
        children: [
          Text(
            'Stay Informed, Effortlessly',
            textAlign: TextAlign.center,
            style: GoogleFonts.splineSans(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: AppTheme.textPrimary,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Get breaking news alerts, personalized feeds, and in-depth analysis right at your fingertips.',
            textAlign: TextAlign.center,
            style: GoogleFonts.splineSans(
              fontSize: 18,
              color: AppTheme.textSecondary,
              height: 1.5, // Meniru 'leading-relaxed'
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk tombol di bagian bawah
  Widget _buildBottomButton(BuildContext context) {
    return Padding(
      // Padding untuk tombol sesuai dengan desain
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryColor,
          minimumSize: const Size(double.infinity, 56), // h-14 dan w-full
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0), // rounded-xl
          ),
          elevation: 5.0, // shadow-lg
          // ignore: deprecated_member_use
          shadowColor: AppTheme.primaryColor.withOpacity(0.4),
        ),
        child: Text(
          'Get Started',
          style: GoogleFonts.splineSans(
            color: AppTheme.buttonTextColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}