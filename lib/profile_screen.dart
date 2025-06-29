import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart'; // Tambahkan ini di bagian import
import 'create_article_screen.dart'; // Tambahkan ini di bagian import
import 'your_articles_screen.dart'; // Tambahkan ini di bagian import
import 'notifications_screen.dart'; // Tambahkan di bagian import

// Bagian 1: Definisi Tema Aplikasi
// Warna-warna ini diambil dari kelas-kelas Tailwind (slate-50, slate-900, dll).
class AppTheme {
  static const Color primaryColor = Color(0xFF1672CE);
  static const Color backgroundColor = Color(0xFFF8FAFC); // slate-50
  static const Color borderColor = Color(0xFFE2E8F0);   // slate-200
  static const Color textPrimary = Color(0xFF0F172A);   // slate-900
  static const Color textBody = Color(0xFF1E293B);      // slate-800
  static const Color textMuted = Color(0xFF475569);     // slate-600
  static const Color iconMuted = Color(0xFF64748B);     // slate-500
  static const Color hoverColor = Color(0xFFF1F5F9);    // slate-100
}

// Bagian 2: Widget Utama Halaman
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Indeks untuk BottomNavigationBar, 'Profile' adalah indeks ke-4 (0-based).
  int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Method untuk membangun AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 0,
      scrolledUnderElevation: 1.0,
      // ignore: deprecated_member_use
      shadowColor: Colors.black.withOpacity(0.1),
      shape: const Border(
        bottom: BorderSide(color: AppTheme.borderColor, width: 1.0),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppTheme.textMuted),
        onPressed: () {
          // Aksi tombol kembali, misalnya Navigator.pop(context)
        },
      ),
      title: Text(
        'Profile',
        style: GoogleFonts.notoSans(
          color: AppTheme.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      // Widget kosong untuk menyeimbangkan tombol 'leading'
      actions: const [SizedBox(width: 56)],
    );
  }

  // Method untuk membangun konten utama halaman
  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileHeader(),
          _buildMenuList(),
        ],
      ),
    );
  }

  // Widget untuk header profil (avatar dan nama)
  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          children: [
            // Avatar dengan efek 'ring'
            Container(
              padding: const EdgeInsets.all(4.0), // Ini adalah 'ring-offset'
              decoration: const BoxDecoration(
                color: AppTheme.primaryColor,
                shape: BoxShape.circle,
              ),
              child: const CircleAvatar(
                radius: 64, // size-32 -> 128px
                backgroundImage: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAB11Q2frXXGO40QYGDlN8C8CxqyU68aC1TP6L6W78VnqRFP3J_ZPheI9mbAy_WTpLo9EDccGiTfTp-s9r9Yqu_PfVlWJqviAtsSj09TpdKqBE-t3ir1D-ACQC3Xas7XjT5pA1CHuayJCb-Qz6gPEXUESU_aa3vyO0xD4H6A9qBntkUCFD7l7i3cob-Em__yJT4R4A-l-BAjpqWT0K1k9KUEjCF6ZFc6JRjMNdf0sURKxK6saEeMHCTQOb91yanpXpyxE_Gj3Em3U3z"),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Sophia Carter',
              style: GoogleFonts.newsreader(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Editor',
              style: GoogleFonts.notoSans(
                fontSize: 18,
                color: AppTheme.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk daftar menu di bawah profil
  Widget _buildMenuList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              'Account',
              style: GoogleFonts.notoSans(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          ProfileMenuItem(icon: Icons.edit, text: 'Edit Profile', onTap: () {}),
          ProfileMenuItem(
            icon: Icons.upload_file,
            text: 'My Articles',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const YourArticlesScreen()),
              );
            },
          ),
          ProfileMenuItem(icon: Icons.notifications, text: 'Notification Preferences', onTap: () {}),
          ProfileMenuItem(icon: Icons.settings, text: 'App Settings', onTap: () {}),
          ProfileMenuItem(icon: Icons.help_outline, text: 'Help & Support', onTap: () {}),
        ],
      ),
    );
  }
  
  // Method untuk membangun Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.borderColor, width: 1.0)),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          // Navigasi ke HomeScreen jika tombol Home ditekan
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          }
          // Navigasi ke CreateArticleScreen jika tombol Create ditekan
          else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateArticleScreen()),
            );
          }
          // Navigasi ke NotificationsScreen jika tombol Notifications ditekan
          else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
            );
          }
          // Navigasi ke ProfileScreen jika tombol Profile ditekan
          else if (index == 4) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
              (route) => false,
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.backgroundColor,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.textMuted,
        selectedLabelStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Create'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

// Bagian 3: Widget Kustom untuk Item Menu Profil
// Membuat widget terpisah agar kode tidak berulang dan lebih rapi.
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // ListTile adalah widget yang ideal untuk baris seperti ini.
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: AppTheme.textMuted),
      title: Text(
        text,
        style: GoogleFonts.notoSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.textBody,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppTheme.iconMuted),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      hoverColor: AppTheme.hoverColor,
      splashColor: AppTheme.borderColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    );
  }
}