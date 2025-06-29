import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart'; // Tambahkan ini
import 'profile_screen.dart'; // Tambahkan ini di bagian import
import 'notifications_screen.dart'; // Tambahkan di bagian import
import '../services/api_service.dart'; // Import ApiService

// Bagian 1: Definisi Tema Aplikasi
// Variabel warna dan gaya teks yang diambil dari CSS.
class AppTheme {
  static const Color primaryColor = Color(0xFF1672CE);
  static const Color secondaryColor = Color(0xFFE7EDF3);
  static const Color accentColor = Color(0xFF4E7397);
  static const Color textPrimary = Color(0xFF0E141B);
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFF8FAFC); // Tidak terpakai di UI ini
}

// Bagian 2: Widget Utama Halaman
class CreateArticleScreen extends StatefulWidget {
  const CreateArticleScreen({super.key});

  @override
  State<CreateArticleScreen> createState() => _CreateArticleScreenState();
}

class _CreateArticleScreenState extends State<CreateArticleScreen> {
  // Indeks untuk BottomNavigationBar, 'Create' adalah indeks ke-2
  int _selectedIndex = 2;
  String? _selectedCategory = 'Technology';
  final List<String> _categories = ['Technology', 'Science', 'Health', 'Business', 'Education'];

  // Controller untuk mengambil nilai dari TextField
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Method untuk membangun AppBar di bagian atas
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 1.0,
      // ignore: deprecated_member_use
      shadowColor: Colors.black.withOpacity(0.1),
      // Tombol 'close' di sebelah kiri
      leading: IconButton(
        icon: const Icon(Icons.close, color: AppTheme.textPrimary),
        onPressed: () {
          // Aksi untuk menutup halaman, misalnya Navigator.pop(context)
        },
      ),
      title: Text(
        'New Article',
        style: GoogleFonts.notoSans(
          color: AppTheme.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      // Memastikan judul berada di tengah
      centerTitle: true,
    );
  }

  // Method untuk membangun konten utama halaman
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kolom input untuk Judul
          _buildTextField(
            controller: _titleController,
            hintText: 'Title',
            isTitle: true,
          ),
          const SizedBox(height: 24),
          _buildCategoryDropdown(),
          const SizedBox(height: 24.0),
          // Kolom input untuk Konten Artikel
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  hintText: 'Enter image URL',
                  filled: true,
                  fillColor: const Color(0xFFE9EEF3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
              const SizedBox(height: 16), // <-- Spasi antar kolom
              TextField(
                controller: _contentController,
                maxLines: 8,
                decoration: InputDecoration(
                  hintText: 'Write your article here...',
                  filled: true,
                  fillColor: const Color(0xFFE9EEF3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Bagian 'Add to your post'
          _buildAttachmentSection(),
          const SizedBox(height: 32),
          // Tombol untuk menyimpan atau mengirim artikel
          _buildCreateButton(),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: GoogleFonts.notoSans(color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        DropdownButtonFormField<String>(
          value: _selectedCategory,
          items: _categories.map((String category) {
            return DropdownMenuItem<String>(
              value: category,
              child: Text(category),
            );
          }).toList(),
          onChanged: (newValue) {
            setState(() {
              _selectedCategory = newValue;
            });
          },
          decoration: _inputDecoration(''),
          style: GoogleFonts.notoSans(color: AppTheme.textPrimary),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppTheme.textSecondary),
        ),
      ],
    );
  }

  // Tambahkan method _inputDecoration
  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.notoSans(color: AppTheme.accentColor),
      filled: true,
      fillColor: AppTheme.secondaryColor,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2.0),
      ),
    );
  }

  // Method untuk membangun kolom input yang dapat digunakan kembali
  Widget _buildTextField({required String hintText, bool isTitle = false, int minLines = 1, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      style: GoogleFonts.notoSans(
        fontSize: isTitle ? 18 : 16,
        fontWeight: isTitle ? FontWeight.w600 : FontWeight.normal,
        color: AppTheme.textPrimary,
      ),
      minLines: minLines,
      maxLines: null, // Memungkinkan input untuk melebar
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.notoSans(color: AppTheme.accentColor),
        filled: true,
        fillColor: AppTheme.secondaryColor,
        contentPadding: const EdgeInsets.all(16),
        // Meniru border-transparent
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        // Meniru focus:ring-2
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2.0),
        ),
      ),
    );
  }

  // Method untuk membangun bagian lampiran dengan grid
  Widget _buildAttachmentSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Add to your post',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blueGrey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCircleIconButton(
                icon: Icons.image,
                label: 'Image',
                onTap: () {
                  // aksi pilih gambar
                },
              ),
              _buildCircleIconButton(
                icon: Icons.videocam,
                label: 'Video',
                onTap: () {
                  // aksi pilih video
                },
              ),
              _buildCircleIconButton(
                icon: Icons.link,
                label: 'Link',
                onTap: () {
                  // aksi pilih link
                },
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // Tambahkan builder berikut di bawah:
  Widget _buildCircleIconButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(32),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 28, color: Colors.black87),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ],
    );
  }

  // Method untuk membangun tombol 'Create'
  Widget _buildCreateButton() {
    return Center(
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF23A6F0), // Biru sesuai gambar
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded
            ),
            padding: const EdgeInsets.symmetric(vertical: 8), // Tinggi tombol tipis
            elevation: 0,
          ),
          onPressed: () async {
            final result = await ApiService.createArticle({
              "title": _titleController.text,
              "category": _selectedCategory,
              "readTime": "5 menit",
              "imageUrl": _imageUrlController.text,
              "tags": [],
              "content": _contentController.text,
            });
            if (result['success']) {
              // ignore: use_build_context_synchronously
              Navigator.pop(context, true); // Kembali ke YourArticlesScreen
            } else {
              // ignore: use_build_context_synchronously
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result['message'] ?? 'Failed to create article')),
              );
            }
          },
          child: const Text(
            'Post',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  // Method untuk membangun Bottom Navigation Bar
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppTheme.secondaryColor, width: 1.0)),
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
            // Sudah di halaman ini, bisa kosong atau refresh
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfileScreen()),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.backgroundColor,
        selectedItemColor: AppTheme.primaryColor,
        unselectedItemColor: AppTheme.accentColor,
        selectedLabelStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 12),
        unselectedLabelStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w500, fontSize: 12),
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

// Bagian 3: Widget Kustom untuk Tombol Lampiran
// Widget ini dibuat agar kode grid tidak berulang.
class AttachmentButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const AttachmentButton({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: AppTheme.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      onPressed: () {
        // Aksi ketika tombol ditekan
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppTheme.primaryColor, size: 30),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.notoSans(
              color: AppTheme.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}