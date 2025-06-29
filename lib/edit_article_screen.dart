import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'your_articles_screen.dart'; // Import model Article

// Bagian 1: Definisi Tema Aplikasi
// Warna dan gaya teks yang konsisten sesuai dengan CSS.
class AppTheme {
  static const Color primaryColor = Color(0xFF1672CE);
  static const Color secondaryColor = Color(0xFFE7EDF3);
  static const Color textPrimary = Color(0xFF0E141B);
  static const Color textSecondary = Color(0xFF4E7397);
  static const Color backgroundColor = Color(0xFFF8FAFC);
}

// Bagian 2: Widget Utama Halaman
class EditArticleScreen extends StatefulWidget {
  final Article article;
  const EditArticleScreen({super.key, required this.article});

  @override
  State<EditArticleScreen> createState() => _EditArticleScreenState();
}

class _EditArticleScreenState extends State<EditArticleScreen> {
  final List<String> _categories = [
    'Technology',
    'Science',
    'Health',
    'Business',
    'Education',
  ];

  String? _selectedCategory; // Add this line

  late TextEditingController _titleController;
  late TextEditingController _dateController;
  late TextEditingController _imageUrlController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.article.title);
    _dateController = TextEditingController(text: widget.article.publishedDate);
    _imageUrlController = TextEditingController(text: widget.article.imageUrl);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _dateController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildAppBar(context),
      body: _buildBody(),
      // Footer dibuat menggunakan bottomNavigationBar untuk posisi 'sticky'
      bottomNavigationBar: _buildFooter(),
    );
  }

  // Method untuk membangun AppBar
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 1.0,
      // ignore: deprecated_member_use
      shadowColor: Colors.black.withOpacity(0.1),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.textPrimary, size: 24),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        'Edit Article',
        style: GoogleFonts.notoSans(
          color: AppTheme.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      // Widget kosong di actions untuk menyeimbangkan tombol 'leading'
      // agar judul benar-benar berada di tengah.
      actions: const [SizedBox(width: 48)],
    );
  }

  // Method untuk membangun konten utama (formulir)
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextField(label: 'Title', hint: 'Enter article title', controller: _titleController),
          const SizedBox(height: 24.0),
          _buildTextField(label: 'Published Date', hint: 'Enter published date', controller: _dateController),
          const SizedBox(height: 24.0),
          _buildTextField(label: 'Image URL', hint: 'Enter image URL', controller: _imageUrlController),
          const SizedBox(height: 24.0),
          _buildCategoryDropdown(),
          const SizedBox(height: 24.0),
          _buildTextField(label: 'Content', hint: 'Write your article content here...', minLines: 8, controller: TextEditingController()),
          const SizedBox(height: 24.0),
          _buildImageUploader(),
        ],
      ),
    );
  }

  // Method untuk membangun footer dengan tombol aksi
  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        border: Border(top: BorderSide(color: Colors.grey.shade200, width: 1.0)),
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.visibility),
              label: const Text('Preview'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                foregroundColor: AppTheme.textPrimary,
                backgroundColor: AppTheme.secondaryColor,
                elevation: 0,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.save),
              label: const Text('Update'),
              onPressed: () {
                // Simpan perubahan (bisa update ke backend di sini)
                Navigator.pop(context, Article(
                  title: _titleController.text,
                  publishedDate: _dateController.text,
                  imageUrl: _imageUrlController.text,
                  body: '', // Tambahkan jika ada field body
                  category: _selectedCategory ?? '',
                ));
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: AppTheme.primaryColor,
                elevation: 2.0,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                textStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // WIDGET-WIDGET PEMBANTU UNTUK FORMULIR

  // Widget untuk membuat field input teks dengan label
  Widget _buildTextField({required String label, required String hint, int minLines = 1, required TextEditingController controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.notoSans(color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: minLines > 1 ? null : 1,
          decoration: _inputDecoration(hint),
          style: GoogleFonts.notoSans(color: AppTheme.textPrimary),
        ),
      ],
    );
  }

  // Widget untuk membuat dropdown kategori
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

  // Widget untuk bagian unggah gambar
  Widget _buildImageUploader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Cover Image',
          style: GoogleFonts.notoSans(color: AppTheme.textSecondary, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            // NOTE: Flutter tidak memiliki border dashed bawaan.
            // Ini adalah pendekatan dengan border solid.
            // Untuk border dashed, package seperti `dotted_border` bisa digunakan.
            border: Border.all(color: Colors.grey.shade300, width: 2.0),
          ),
          child: Column(
            children: [
              // Preview Gambar
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: const DecorationImage(
                    image: NetworkImage("https://lh3.googleusercontent.com/aida-public/AB6AXuAAXwwvdgqTXlV366cXIU9dieXnEVHuaTFC3ffCKgT8Ck7qhKeiNbU0yGwzf6WaEtqqwvRf2NOdG_lrVC4gVNN6B1zD0_OHTcwPP5R8vFpTcAKGMlYTOolsAUdUi39XYH6FtbMfEmmQmHKgEcC2FTZv9-svE_2dmHOrPKrZXme6NrcfbYt5p9SmRe4DF6_Kjbo0ihD0t60_EtoGcSCeHF7SaJZVDyBkTiTZxLECDPkD8NGm5ocXLwi2F6lItS8-VqfUbgQAtSGd9IS0"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Teks Aksi
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: GoogleFonts.notoSans(fontSize: 14, color: Colors.grey.shade600),
                  children: [
                    TextSpan(
                      text: 'Change image',
                      style: const TextStyle(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        // Aksi untuk memilih file
                      },
                    ),
                    const TextSpan(text: ' or drag and drop'),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'PNG, JPG, GIF up to 10MB',
                style: GoogleFonts.notoSans(fontSize: 12, color: Colors.grey.shade500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Dekorasi input yang dapat digunakan kembali untuk konsistensi
  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: GoogleFonts.notoSans(color: AppTheme.textSecondary),
      filled: true,
      fillColor: AppTheme.secondaryColor,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppTheme.primaryColor, width: 2.0),
      ),
    );
  }
}

final TextEditingController titleController = TextEditingController();

@override
Widget build(BuildContext context) {
  return _buildTextField(
    controller: titleController, // Pass the controller, not null
    label: 'Title',
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  int maxLines = 1,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    ),
    maxLines: maxLines,
  );
}