// File: homescreen.dart

import 'package:flutter/material.dart';
import 'create_article_screen.dart';
import 'profile_screen.dart'; // Tambahkan ini
import 'notifications_screen.dart'; // Tambahkan di bagian import

// =============================================================
// 1. DATA MODELS
// Memisahkan data dari UI adalah praktik terbaik.
// =============================================================
class Article {
  final String category;
  final String title;
  final String description;
  final String imageUrl;
  final String time;

  const Article({
    required this.category,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.time,
  });
}

// =============================================================
// 2. WIDGET LAYAR UTAMA (HOMESCREEN)
// =============================================================
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- State Variables ---
  int _bottomNavIndex = 0;
  String _selectedCategory = 'For You';

  // --- Data Source (Contoh data, bisa diganti dari API) ---
  final List<Article> _latestNews = const [
    Article(
      category: 'Technology',
      title: 'Tech giants invest in AI research',
      description:
          'Leading tech companies are pouring billions into artificial intelligence research, aiming to revolutionize industries and enhance user experiences across various sectors.',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCMV8Z_1ooHaHVCX7t5sWeFOqJvGbWthCeKAwEvbQIzEhutnJ1cRgQ-sFDMLIUpALs3suGEzBWxn54xVOHhu_JqGI_mbp1sMaCK93s71CW1KwfnQmSWUZN0eTQAG58YpwHuFDMCAxI_QWpheQAeM3NMGFB8b4jt3ravPeS3u2ZGclBQjvjGHzdSVaZkxDKPHB48wJ_tATgyd6YP02GcSOjD9wxqm24PThK7vLBOk28HGi6GHtGNkuFJAKWLS8xJhJlkowS6_T7XigpC',
      time: '2 hours ago',
    ),
    Article(
      category: 'Politics',
      title: 'Government announces new economic policy',
      description:
          'The government unveiled a comprehensive economic policy aimed at boosting growth, creating jobs, and reducing inequality through targeted investments and fiscal reforms.',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBQAwadxpSXh47BCeokOzXFkJqHbFwZc29C74Wj6AaSEaTf43R_C8LmsMa48kc_yZG2zE-CI2pSTdyxrNc1j2Gj3YAl5TNkAwD7Tahe3xPFx7z27gX7ZYflZ5btUKSsbzc15HJIsxokINGvpcY63W3vVifZPIjD4vCqUxagsTnI0hnS_1tiJoWrClCT2YI90loHvtR_Yr7mwwVaKD_Zxistf9nc2W-HKmA5UxUemJgNR1_mberQ83wC3T_8y21if5jVQMu7-KAK_pu-',
      time: '5 hours ago',
    ),
    Article(
      category: 'Business',
      title: 'Market sees record gains',
      description:
          'The stock market experienced a surge, reaching record highs as investor confidence soared amid positive economic indicators and strong corporate earnings.',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuCrChucb0M1eBu-yKpIMsKwL9UzYoee2R8rUkweZSH8cANXkFyRXMwbSSr1XAovXJ5JDXNkKCoL368i4Qgf_HaYGiPlyNVmMEjo_jbmMvi96sCXusFmMxYR9HFwSjimkG6QRtxqRpw5SG1O1nkiDJyI00zWnjAkfx_9s3nboGHhZmsKriazYWZn9e8DUOq6SaCMyr2EV9iWB31ZQHtKPCsMBKsBr0Z6ytdeBI0_6FE0wWooGUr_4ownmXKNLtWHpoC6WIJu5_qfXQ2K',
      time: 'Yesterday',
    ),
  ];

  final List<Article> _trendingNews = const [
    Article(
      category: 'Science',
      title: 'New discovery in space exploration',
      description:
          'Scientists have made a groundbreaking discovery in space, potentially altering our understanding of the universe.',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuAZv34QP0yPALmosZP1WtiTacm2j_xfNDEPu8G6S9QhDgLTf9Nhbr0_2M_K6At3tHMqaSVrK526w9SCHvwLIcZS9UCczMQBFPb0skJ2SfcZXOT8gcJsM_ZtCkGFDbfg86wY4umX-3aG-NitusFYrSuR6Mvp2mUqRpH-1-Q2edI1XP8YUWvNKVPtfHCWlpfeyUz0S_EwMYNm2cQ0OGM3BQLUWx2hM7a1o5iSROPwdWxVwTzRQhv-Af2uMUOsTlY3WQNbZKH2HWdhpgJR',
      time: '3 hours ago',
    ),
    Article(
      category: 'Health',
      title: 'Breakthrough in cancer treatment',
      description:
          'Researchers have announced a significant breakthrough in cancer treatment, offering hope for improved outcomes.',
      imageUrl: 'https://lh3.googleusercontent.com/aida-public/AB6AXuBj1G0-NR7-hw_7iPow9-Y8dCYMTvN7492DwOqEHYsNa0nlwPXWSP5Fhp7g2Lj-LxeEyyR3zSLYSjAVTGuIuiyEoZKKrm6KNJcYGiJbs6P8xFWBxT3WPs-GrSue5nLsQpQo4kBrX3lRfxtjsxAOnq9oiYrtnCio1UJqiPW_Y6qqVdE_crtvHpnQDgaF3DlxV0SJnnBEbOVeDYR3W2rgquUuz0DSVnfPqDok88g1-f7RYPx5TAHiSNKSbPTF8_R-orFNV1eA6TvpUOqW',
      time: '10 hours ago',
    ),
  ];

  final List<String> _categories = const [
    'For You',
    'Top Stories',
    'Politics',
    'Business',
    'Technology',
    'Sports'
  ];

  // --- Build Method ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildSectionHeader('Latest News'),
          _buildLatestNewsList(),
          _buildSectionHeader('Trending Now'),
          _buildTrendingNewsGrid(),
          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // --- Helper Methods untuk Membangun UI ---

  SliverAppBar _buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.background,
      pinned: true,
      floating: true,
      elevation: 1.0,
      // ignore: deprecated_member_use
      shadowColor: Colors.grey.withOpacity(0.5),
      leading: IconButton(
        icon: const Icon(Icons.menu, color: AppColors.textPrimary),
        onPressed: () {},
      ),
      title: const Text('NewsFeed',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings, color: AppColors.textPrimary),
          onPressed: () {},
        ),
      ],
      bottom: PreferredSize(
        // SOLUSI: Tinggi dinaikkan menjadi 135.0 untuk memperbaiki overflow
        preferredSize: const Size.fromHeight(135.0),
        child: Column(
          children: [
            _buildSearchBar(),
            _buildCategoryChips(),
          ],
        ),
      ),
    );
  }
  
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search news, topics...',
          hintStyle: const TextStyle(color: AppColors.textSecondary),
          prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
          filled: true,
          fillColor: AppColors.accent,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedCategory = category;
                });
              },
              backgroundColor: AppColors.accent,
              selectedColor: AppColors.primary,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: BorderSide.none,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }

  Widget _buildLatestNewsList() {
    return SliverList.builder(
      itemCount: _latestNews.length,
      itemBuilder: (context, index) {
        return LatestNewsCard(article: _latestNews[index]);
      },
    );
  }

  Widget _buildTrendingNewsGrid() {
    return SliverPadding(
      padding: const EdgeInsets.all(8.0),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: MediaQuery.of(context).size.width > 600 ? 1.2 : 1.3,
        ),
        itemCount: _trendingNews.length,
        itemBuilder: (context, index) {
          return TrendingNowCard(article: _trendingNews[index]);
        },
      ),
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
        if (index == 2) {
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
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.secondary,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      backgroundColor: AppColors.background,
      elevation: 5.0,
    );
  }
}

// =============================================================
// 3. WIDGET KARTU BERITA
// Menerima object Article, bukan parameter terpisah.
// =============================================================

class LatestNewsCard extends StatelessWidget {
  final Article article;
  const LatestNewsCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 2.0,
        // ignore: deprecated_member_use
        shadowColor: Colors.grey.withOpacity(0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: AppColors.cardBackground,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.category.toUpperCase(),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      article.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      article.description.trim(),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14.0,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      article.time,
                      style: const TextStyle(
                        color: AppColors.gray400,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  article.imageUrl,
                  width: 112,
                  height: 112,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                      width: 112,
                      height: 112,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported,
                          color: Colors.grey)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TrendingNowCard extends StatelessWidget {
  final Article article;
  const TrendingNowCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      // ignore: deprecated_member_use
      shadowColor: Colors.grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.antiAlias,
      color: AppColors.cardBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            article.imageUrl,
            width: double.infinity,
            height: 160.0,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
                width: double.infinity,
                height: 160,
                color: Colors.grey[200],
                child: const Icon(Icons.image_not_supported, color: Colors.grey)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.category.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    article.description.trim(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14.0,
                      height: 1.4,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    article.time,
                    style: const TextStyle(
                      color: AppColors.gray400,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// 4. DEFINISI WARNA APLIKASI
// =============================================================
class AppColors {
  static const Color primary = Color(0xFF0C7FF2);
  static const Color secondary = Color(0xFF6B7280);
  static const Color background = Color(0xFFF8FAFC);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color accent = Color(0xFFEEF2FF);
  static const Color gray400 = Color(0xFF9CA3AF);
}