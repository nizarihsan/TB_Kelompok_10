import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'services/api_service.dart';
import 'article_detail_screen.dart'; // Pastikan file ini ada dan berisi ArticleDetailScreen
import 'create_article_screen.dart'; // Pastikan file ini ada dan berisi CreateArticleScreen
import 'notifications_screen.dart'; // Pastikan file ini ada dan berisi NotificationsScreen

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
  static const Color bodyBg = Color(0xFFF6F8FA); // Added missing bodyBg
}

// Tambahkan widget ProfileScreen jika belum ada
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(
        child: Text('Profile Screen'),
      ),
    );
  }
}

// Bagian 2: Model Data untuk Artikel
class Article {
  final String id;
  final String imageUrl;
  final String title;
  final String category;
  final String publishedAt;
  final String readTime;
  final String content;
  final String? authorName;
  final String? authorAvatar;

  Article({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.category,
    required this.publishedAt,
    required this.readTime,
    required this.content,
    this.authorName,
    this.authorAvatar,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id']?.toString() ?? '',
      imageUrl: json['imageUrl'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      readTime: json['readTime'] ?? '',
      content: json['content'] ?? '',
      authorName: json['author']?['name'],
      authorAvatar: json['author']?['avatar'],
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
  int _bottomNavIndex = 0;
  List<Article> _articles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles({int page = 1, int limit = 10, String? category}) async {
    setState(() => _isLoading = true);
    try {
      final result = await ApiService.getArticles(page: page, limit: limit, category: category);
      setState(() {
        _articles = (result['data']['articles'] as List)
            .map((e) => Article.fromJson(e))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      // Handle error (tampilkan snackbar, dsb)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bodyBg,
      appBar: _buildAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
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
    if (_articles.isEmpty) {
      return const Center(child: Text('Tidak ada artikel.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _articles.length,
      itemBuilder: (context, index) => ListTile(
        leading: Image.network(_articles[index].imageUrl, width: 80, fit: BoxFit.cover),
        title: Text(_articles[index].title),
        subtitle: Text(_articles[index].category),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailScreen(articleId: _articles[index].id),
            ),
          );
        },
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 24),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Create'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
      currentIndex: _bottomNavIndex,
      onTap: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchScreen()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateArticleScreen()),
          );
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationsScreen()),
          );
        } else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        } else {
          setState(() => _bottomNavIndex = index);
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppTheme.primaryColor,
      unselectedItemColor: AppTheme.textSecondary,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      backgroundColor: AppTheme.navBg,
      elevation: 5.0,
    );
  }
}