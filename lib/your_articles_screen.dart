import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';
import 'create_article_screen.dart';
import 'profile_screen.dart';
import 'notifications_screen.dart'; // Tambahkan di bagian import
import 'edit_article_screen.dart'; // Tambahkan import ini

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
// Membuat model data membuat kode daftar menjadi lebih bersih.
class Article {
  final String title;
  final String publishedDate;
  final String imageUrl;

  Article({
    required this.title,
    required this.publishedDate,
    required this.imageUrl, required String body, required String category,
  });
}

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
  final List<Article> articles = [
    Article(
      title: 'The Future of Sustainable Energy',
      publishedDate: 'Published 2 days ago',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDDWqxKPhtwwROoblRlTV0RcEuyKttJ0j1-Qdjttfrrw6NcxzBOgDPoO8L9PX0ntBqEs752cauM5cH8HsFTmI87Og6lZCD9zt9IOS2XA5mrMf4zD5MwE7pDneMBGQo2ZgJXPIUmLF3sZP-7ZyavTZgwceOcGNbO6g5gKjZ-l4yD8Cpt8E1lamQ0zuQmqJ4nMD0uEDvw2MxhHWj8U9WVsFd7Tz2oCOmQETor3tahlAswKcswglfGkWhsPoDCL1KtT795asm30U13oOC2', body: '', category: '',
    ),
    Article(
      title: 'Exploring the Depths of the Ocean',
      publishedDate: 'Published 1 week ago',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuB0XNeeZiBLvmnYHG50sl4aSb0UzTgMHiLtsd-4y922ROevWdA894upmdM03hzhqRso3YaxXKs3OE8au88GsMo8KI5D_FjeV2R0f9w_DXcxGPmPJpX99qgp6U3PtdfLe9RdnBsBUq1vxJdAaSEPExwcKiIiO_vd7NG7vWc6WJ3e7muNS1NxdIpZZbLr2Rfa2h2K858N8bUPLavSgxElWRAKucbpqe_l8zD8KFu9b9cBtAo_yft0c6Chh74RiY0zJxoWIKHZxVm7z5Ni', body: '', category: '',
    ),
    Article(
      title: 'The Rise of Artificial Intelligence',
      publishedDate: 'Published 2 weeks ago',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuDFyc3P8puYxTQuvnw-hFb4ZzmJwG0xnEXWbQv5kcfgLibjRtWthtMmDwQ0a6m4t_j6yJISdHrN2zFyePn4bb3ajU0FoN4Z4M_fTewT2T2w-OrjD8SklRCsZd3NCoFfUfOr5ybYVeB2ciSBIZlS6bAFqiRIIgp-og46xwxHGQLg3I8cmqyjqkTODrcCHOGRDK4ikfpJvCOyD3kvAltp8hzPj1RUPxqX2MoQf6oMpWHtq9b2ucEfXNy-dE8M0v-MsnUpOb2C2i_JQ3F_', body: '', category: '',
    ),
  ];

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
            final newArticle = await Navigator.push<Article>(
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
                  articles[index] = updatedArticle;
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
                      setState(() {
                        articles.removeAt(index);
                      });
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
  final Article article;
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
                    article.publishedDate,
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