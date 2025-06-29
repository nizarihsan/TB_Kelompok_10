import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tb10/services/api_service.dart';

// Bagian 1: Definisi Tema Aplikasi
class AppTheme {
  static const Color primaryColor = Color(0xFFB2CAE5);
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color navBg = Color(0xFFFFFFFF);
  static const Color navBorder = Color(0xFFE2E8F0);
  static const Color navIconActive = Color(0xFF1A202C);
  static const Color navIconInactive = Color(0xFF718096);
  static const Color bodyBg = Color(0xFFF9FAFB); // bg-gray-50
}

// Bagian 2: Model Data untuk Artikel
class Article {
  final String imageUrl;
  final String title;
  final String description;
  final String timeAgo;

  Article({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.timeAgo,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      imageUrl: json['imageUrl'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      timeAgo: json['timeAgo'] ?? '',
    );
  }
}

// Bagian 3: String SVG untuk Ikon
// Menyimpan data SVG sebagai string agar mudah dikelola.
class AppIcons {
  static const String search =
      '<svg fill="currentColor" viewBox="0 0 256 256"><path d="M229.66,218.34l-50.07-50.06a88.11,88.11,0,1,0-11.31,11.31l50.06,50.07a8,8,0,0,0,11.32-11.32ZM40,112a72,72,0,1,1,72,72A72.08,72.08,0,0,1,40,112Z"></path></svg>';
  static const String home =
      '<svg fill="currentColor" viewBox="0 0 256 256"><path d="M224,115.55V208a16,16,0,0,1-16,16H168a16,16,0,0,1-16-16V168a8,8,0,0,0-8-8H112a8,8,0,0,0-8,8v40a16,16,0,0,1-16,16H48a16,16,0,0,1-16-16V115.55a16,16,0,0,1,5.17-11.78l80-75.48.11-.11a16,16,0,0,1,21.53,0,1.14,1.14,0,0,0,.11.11l80,75.48A16,16,0,0,1,224,115.55Z"></path></svg>';
  static const String forYou =
      '<svg fill="currentColor" viewBox="0 0 256 256"><path d="M208,32H48A16,16,0,0,0,32,48V208a16,16,0,0,0,16,16H208a16,16,0,0,0,16-16V48A16,16,0,0,0,208,32Zm0,16V152h-28.7A15.86,15.86,0,0,0,168,156.69L148.69,176H107.31L88,156.69A15.86,15.86,0,0,0,76.69,152H48V48Zm0,160H48V168H76.69L96,187.31A15.86,15.86,0,0,0,107.31,192h41.38A15.86,15.86,0,0,0,160,187.31L179.31,168H208v40Z"></path></svg>';
  static const String save =
      '<svg fill="currentColor" viewBox="0 0 256 256"><path d="M184,32H72A16,16,0,0,0,56,48V224a8,8,0,0,0,12.24,6.78L128,193.43l59.77,37.35A8,8,0,0,0,200,224V48A16,16,0,0,0,184,32Zm0,16V161.57l-51.77-32.35a8,8,0,0,0-8.48,0L72,161.56V48ZM132.23,177.22a8,8,0,0,0-8.48,0L72,209.57V180.43l56-35,56,35v29.14Z"></path></svg>';
  static const String profile =
      '<svg fill="currentColor" viewBox="0 0 256 256"><path d="M230.92,212c-15.23-26.33-38.7-45.21-66.09-54.16a72,72,0,1,0-73.66,0C63.78,166.78,40.31,185.66,25.08,212a8,8,0,1,0,13.85,8c18.84-32.56,52.14-52,89.07-52s70.23,19.44,89.07,52a8,8,0,1,0,13.85-8ZM72,96a56,56,0,1,1,56,56A56.06,56.06,0,0,1,72,96Z"></path></svg>';
}

// Bagian 4: Widget Utama Halaman
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selectedIndex = 0; // "Beranda" aktif secara default

  List<Article> _articles = []; // Daftar artikel yang akan ditampilkan

  @override
  void initState() {
    super.initState();
    fetchBookmarks(); // Ambil data bookmark saat inisialisasi
  }

  Future<void> fetchBookmarks() async {
    final result = await ApiService.getBookmarks();
    setState(() {
      _articles = (result['data']['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bodyBg,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.navBg,
      elevation: 1.0,
      shadowColor: AppTheme.navBorder,
      shape: const Border(bottom: BorderSide(color: AppTheme.navBorder)),
      leading: const SizedBox(width: 48), // Spacer kiri
      centerTitle: true,
      title: Text(
        'Berita',
        style: GoogleFonts.newsreader(
          color: AppTheme.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: SvgPicture.string(
            AppIcons.search,
            height: 24,
            width: 24,
            colorFilter: const ColorFilter.mode(AppTheme.textPrimary, BlendMode.srcIn),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _articles.length,
      itemBuilder: (context, index) => ArticleCard(article: _articles[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 24),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.navBg,
        border: Border(top: BorderSide(color: AppTheme.navBorder, width: 1.0)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _BottomNavItem(
                svgData: AppIcons.home,
                label: 'Beranda',
                isActive: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
              ),
              _BottomNavItem(
                svgData: AppIcons.forYou,
                label: 'Untuk Anda',
                isActive: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
              ),
              _BottomNavItem(
                svgData: AppIcons.save,
                label: 'Simpan',
                isActive: _selectedIndex == 2,
                onTap: () => setState(() => _selectedIndex = 2),
              ),
              _BottomNavItem(
                svgData: AppIcons.profile,
                label: 'Profil',
                isActive: _selectedIndex == 3,
                onTap: () => setState(() => _selectedIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Bagian 5: Widget Kustom untuk Kartu Artikel
class ArticleCard extends StatelessWidget {
  final Article article;
  const ArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.cardBg,
      elevation: 4.0,
      // ignore: deprecated_member_use
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              article.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: GoogleFonts.newsreader(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  article.description,
                  style: GoogleFonts.newsreader(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  article.timeAgo,
                  style: GoogleFonts.newsreader(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Bagian 6: Widget Kustom untuk Item Navigasi Bawah
class _BottomNavItem extends StatelessWidget {
  final String svgData;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.svgData,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppTheme.navIconActive : AppTheme.navIconInactive;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 28,
                width: 28,
                child: SvgPicture.string(
                  svgData,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: GoogleFonts.notoSans(
                  fontSize: 11,
                  color: color,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}