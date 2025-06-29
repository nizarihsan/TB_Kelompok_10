import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'create_article_screen.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart'; // Tambahkan di bagian import
import 'edit_article_screen.dart'; // Tambahkan import ini
import 'services/api_service.dart';
import 'models/article.dart' as article_model; // Gunakan prefix untuk menghindari konflik

// Bagian 1: Definisi Tema Aplikasi
// Warna-warna ini diambil dari variabel root CSS.
class AppTheme {
  static const Color primaryColor = Color(0xFFBCD1E5);
  static const Color secondaryColor = Color(0xFFF0F4F8);
  static const Color textPrimary = Color(0xFF111518);
  static const Color textSecondary = Color(0xFF5E7387);
  static const Color accentColor = Color(0xFF3B82F6);
  static const Color white = Colors.white;
  static const Color red = Colors.red;
}

// Bagian 2: Model Data Sederhana untuk Artikel
// Model Article diimpor dari models/article.dart

// Bagian 3: Widget Utama Halaman
class YourArticlesScreen extends StatefulWidget {
  const YourArticlesScreen({super.key});

  @override
  State<YourArticlesScreen> createState() => _YourArticlesScreenState();
}

class _YourArticlesScreenState extends State<YourArticlesScreen> {
  // Indeks untuk BottomNavigationBar, 'Profile' adalah indeks ke-3 (0-based).
  int _selectedIndex = 3;

  // Daftar data artikel
  List<article_model.Article> articles = [];

  @override
  void initState() {
    super.initState();
    fetchUserArticles();
  }

  Future<void> fetchUserArticles() async {
    final result = await ApiService.getUserArticles();
    setState(() {
      articles = (result['data']['articles'] as List)
          .map((e) => article_model.Article.fromJson(e))
          .toList();
    });
  }

  // Untuk delete
  void deleteArticle(String id, int index) async {
    final result = await ApiService.deleteArticle(id);
    if (result['success']) {
      setState(() {
        articles.removeAt(index);
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Failed to delete article')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      appBar: _buildAppBar(),
      body: _buildArticleList(),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.blue, // Ganti warna menjadi biru
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: IconButton(
          icon: const Icon(Icons.add, color: Colors.white, size: 28),
          onPressed: () async {
            final newArticle = await Navigator.push<article_model.Article>(
              context,
              MaterialPageRoute(builder: (context) => const CreateArticleScreen()),
            );
            if (newArticle != null) {
              setState(() {
                articles.add(newArticle);
              });
            }
          },
        ),
      ),
    );
  }

  // Method untuk membangun AppBar
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.white,
      elevation: 1.0,
      // ignore: deprecated_member_use
      shadowColor: Colors.black.withOpacity(0.1),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.textPrimary),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
            (route) => false,
          );
        },
      ),
      title: Text(
        'Your Articles',
        style: GoogleFonts.notoSans(
          color: AppTheme.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: const [SizedBox(width: 56)], // Spacer untuk menyeimbangkan judul
    );
  }

  // Method untuk membangun daftar artikel menggunakan ListView
  Widget _buildArticleList() {
    return ListView.separated(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        return ArticleListItem(
          article: articles[index],
          onEdit: () {
            Navigator.push<Article?>(
              context,
              MaterialPageRoute(
                builder: (context) => EditArticleScreen(article: articles[index]),
              ),
            ).then((updatedArticle) {
              if (updatedArticle != null) {
                setState(() {
                  articles[index] = updatedArticle as article_model.Article;
                });
              }
            });
          },
          onDelete: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Article'),
                content: const Text('Are you sure you want to delete this article?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      deleteArticle(articles[index].id, index);
                      Navigator.pop(context);
                    },
                    child: const Text('Delete', style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
    );
  }

  // Method untuk membangun Bottom Navigation Bar seperti di profile_screen.dart
  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() => _selectedIndex = index);
        if (index == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
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
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
            (route) => false,
          );
        }
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppTheme.white,
      selectedItemColor: AppTheme.accentColor,
      unselectedItemColor: AppTheme.textSecondary,
      selectedLabelStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w600),
      unselectedLabelStyle: GoogleFonts.notoSans(fontWeight: FontWeight.w500),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Create'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}

// Bagian 4: Widget Kustom untuk setiap item dalam daftar artikel
class ArticleListItem extends StatelessWidget {
  final article_model.Article article;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ArticleListItem({
    super.key,
    required this.article,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      // ignore: deprecated_member_use
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Gambar Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                article.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Judul dan Tanggal
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: GoogleFonts.newsreader(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.date, // Ganti dengan properti yang benar dari model Article, misal 'date' atau 'publishedAt'
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Tombol Aksi (Edit & Hapus)
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: AppTheme.accentColor),
                  onPressed: onEdit,
                  splashRadius: 20,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: AppTheme.red),
                  onPressed: onDelete, // <-- gunakan callback ini
                  splashRadius: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}