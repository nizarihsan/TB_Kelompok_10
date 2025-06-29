import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_article_screen.dart'; // Tambahkan di bagian import
import 'profile_screen.dart'; // Tambahkan di bagian import
import 'home_screen.dart'; // Tambahkan di bagian import
import 'services/api_service.dart';

// Bagian 1: Definisi Tema Aplikasi
class AppTheme {
  static const Color primaryColor = Color(0xFF1473CC);
  static const Color secondaryColor = Color(0xFF6B7280);
  static const Color accentColor = Color(0xFFF3F4F6);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF4B5563);
  static const Color textMuted = Color(0xFF9CA3AF); // Added muted text color
  static const Color red = Colors.red;
}

// Bagian 2: Model Data untuk Notifikasi
// Menggunakan model data membuat struktur UI yang kompleks menjadi lebih mudah dikelola.
class NotificationItem {
  final String imageUrl;
  final bool isCircularImage;
  final List<TextSpan> content; // Menggunakan TextSpan untuk teks yang diformat
  final String timeAgo;
  final IconData trailingIcon;
  final Color iconColor;

  NotificationItem({
    required this.imageUrl,
    this.isCircularImage = false,
    required this.content,
    required this.timeAgo,
    required this.trailingIcon,
    required this.iconColor,
  });
}

class NotificationGroup {
  final String title;
  final List<NotificationItem> items;

  NotificationGroup({required this.title, required this.items});
}


// Bagian 3: Widget Utama Halaman Notifikasi
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedIndex = 3;
  List<NotificationGroup> notificationGroups = [];

  @override
  void initState() {
    super.initState();
    fetchTrendingNotifications();
  }

  Future<void> fetchTrendingNotifications() async {
    // Contoh fetch dari API trending
    // Ganti ApiService.getTrendingArticles sesuai implementasi kamu
    final result = await ApiService.getTrendingArticles();
    final articles = result['data']['articles'] as List;
    setState(() {
      notificationGroups = [
        NotificationGroup(
          title: 'Trending Articles',
          items: articles.map((article) => NotificationItem(
            imageUrl: article['imageUrl'] ?? '',
            isCircularImage: false,
            content: [
              TextSpan(
                text: article['title'] ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const TextSpan(text: ' is now trending!'),
            ],
            timeAgo: article['publishedAt'] ?? '',
            trailingIcon: Icons.trending_up,
            iconColor: AppTheme.primaryColor,
          )).toList(),
        ),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppTheme.backgroundColor,
      elevation: 1.0,
      shadowColor: AppTheme.accentColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.textPrimary),
        onPressed: () {},
      ),
      title: Text(
        'Notifications',
        style: GoogleFonts.newsreader(
          color: AppTheme.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: const [SizedBox(width: 56)],
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: notificationGroups.length,
      itemBuilder: (context, index) {
        final group = notificationGroups[index];
        return NotificationGroupWidget(group: group);
      },
    );
  }

  Widget _buildBottomNavigationBar() {
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
        } else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        }
        // ...tambahkan navigasi lain sesuai kebutuhan...
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
    );
  }
}


// Bagian 4: Widget untuk Grup Notifikasi
class NotificationGroupWidget extends StatelessWidget {
  final NotificationGroup group;
  const NotificationGroupWidget({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              group.title,
              style: GoogleFonts.newsreader(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          // Menggunakan ListView agar tidak terjadi overflow jika item dalam grup banyak
          ListView.builder(
            itemCount: group.items.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              final item = group.items[index];
              // Tambahkan border kecuali untuk item terakhir di dalam grup
              final isLastItem = index == group.items.length - 1;
              return NotificationListItemWidget(item: item, isLast: isLastItem);
            },
          )
        ],
      ),
    );
  }
}


// Bagian 5: Widget untuk setiap item notifikasi
class NotificationListItemWidget extends StatelessWidget {
  final NotificationItem item;
  final bool isLast;
  const NotificationListItemWidget({super.key, required this.item, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      hoverColor: Colors.grey.shade50,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          border: isLast 
            ? null 
            : Border(bottom: BorderSide(color: AppTheme.accentColor, width: 1.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Notifikasi
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: ClipRRect(
                borderRadius: item.isCircularImage 
                  ? BorderRadius.circular(24.0) 
                  : BorderRadius.circular(8.0),
                child: Image.network(
                  item.imageUrl,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Konten Teks
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   RichText(
                    text: TextSpan(
                      style: GoogleFonts.newsreader(fontSize: 16, color: AppTheme.textPrimary, height: 1.4),
                      children: item.content,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.timeAgo,
                    style: GoogleFonts.notoSans(color: AppTheme.textSecondary, fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Ikon Trailing
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Icon(item.trailingIcon, color: item.iconColor, size: 22),
            ),
          ],
        ),
      ),
    );
  }
}