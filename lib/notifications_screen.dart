import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'create_article_screen.dart'; // Tambahkan di bagian import
import 'profile_screen.dart'; // Tambahkan di bagian import
import 'home_screen.dart'; // Tambahkan di bagian import

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
  int _selectedIndex = 3; // 'Notifications' adalah indeks ke-3

  // Data notifikasi yang sudah distrukturkan
  final List<NotificationGroup> notificationGroups = [
    NotificationGroup(
      title: 'Breaking News',
      items: [
        NotificationItem(
          imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuA3kgRJWqrh1nw_v4eiaEDN18RBvgX9uETKz7yUt2UkXeXr58okuXKyDbaO1IqhfdF67Jzw7yiR8lTorqCG9bQBCSN9I1fODu8vczI2EmckV0JH0fHslT9_xqxxv8MefNCiYCRs8P7FGjzY13PYiMWiOehSk9lAH7sTQHTX1eSu2rlX1jLyl1cKNJ6oFpgPC1Ti9IA8ZuArdhtY13aOWNZ-HRV3NvHShCVsoCxG2tUEC_p3aahEKTGOzyRJPP343w6S6g4rE-pg3qXs",
          content: [TextSpan(text: 'Major earthquake hits coastal region')],
          timeAgo: '1h ago',
          trailingIcon: Icons.campaign,
          iconColor: AppTheme.primaryColor,
        ),
      ],
    ),
    NotificationGroup(
      title: 'Personalized Updates',
      items: [
        NotificationItem(
          imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuBr7LjPsNQ7ncqJfqzxCI5LUQUeNoaVmiz5Nr6tV3xYRIan4wEhlCZU8w50aXUy7IC1UEHOvXhcN_hhXUvFlhgKtOLB9QoK2GRjEuVBwIAYE95mPiGP2nI8VXEkg8nZHCxfTNFFNs7HM6Sv8Tw3YU0c1-QcTO8ubIZrBSHz6LMoy2s78lkjDt-tzKKhhGAVkD2y8RkjeqzP7krlycGXZnbI-yXdcvY6c6ZHa1WV3liBDVf7CREVHmgU6pjMDAP90pKqlsRYjqNcfvkr",
          content: [TextSpan(text: 'Your favorite author, Amelia Stone, has a new article')],
          timeAgo: '2h ago',
          trailingIcon: Icons.article,
          iconColor: AppTheme.primaryColor,
        ),
        NotificationItem(
          imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuArpZjqlQYEWRcX1ZHKXVX8WfKOaajTyKW_fcnYStghuhNLjhbZOAxnpB0fl5COA2JOpUSbyb0QiLS7PLLgWGGKapHnzTfjnQ6fgZgfCsM5Ni6sueoxWDNyx5WPD5tXFF5AHqskATLb8k9jIMM32CzUQIPHRyPZGyoYmktH6xansq_U6Lbg5Zb-CvFlf40GPmLfEzz-jwfx6YDjglHwTVZJedwKiBXjupv2aNdh1sM-Bl1Y6jHZtQQgcoMxYTjUpRatyU6vs-Qh-8Ru",
          content: [TextSpan(text: 'Trending: Climate change solutions')],
          timeAgo: '3h ago',
          trailingIcon: Icons.trending_up,
          iconColor: AppTheme.primaryColor,
        ),
      ],
    ),
     NotificationGroup(
      title: 'Interactions',
      items: [
        NotificationItem(
          imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAkAwX_O7fA1r1gSyycjed1yw4VM70KKnG72rCK_qTkAaWzJO-dNzXUaX17i9atf8N2fVpya3f1o3jBeMlnAOmLH9weRQvvE4PlvkZzzzK_pax-ZXy8fjlPNr3Hgkj_IxLVEbGrvlsuPK6tVZHnDwzRVobO8IN8ctUUUq-PI51nXl9hwiOeq3LqKXPm_2EjzvplJLf0GyLGHFL1gUjUdvhFcFPTRM1wSKigWrCK2IgiiEeztK7kt3LfpILtnoII6p4yd9sqMDqPmHr8",
          isCircularImage: true,
          content: [
            const TextSpan(text: 'Ethan Carter ', style: TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: 'liked your comment on the latest tech review', style: TextStyle(fontWeight: FontWeight.normal, color: AppTheme.textSecondary)),
          ],
          timeAgo: '4h ago',
          trailingIcon: Icons.favorite,
          iconColor: AppTheme.red,
        ),
         NotificationItem(
          imageUrl: "https://lh3.googleusercontent.com/aida-public/AB6AXuAUYVF3ULKIpv7J04E7O0wsb51n83DfO9PdmDtVmnuAvZG4rglr9DxhTAgxwlVO-L4t1623Et6AmocHiWpb2vjGJjBjIDZvseoxFwndQ4c0Smo95KOi-g2ps0FmTs6obRGYRHeRibojWNJ3wAft9hUuonKPWnUHJJAecvl99PcdejYqaSn4geaFX5PZ5mORkDe28I1eQKZ_OZvLA30WXn4aVhKGkCVc8VVIFW-EZqsDiILxUpuLqnUMY8KNRNUlqM7JIO1KJT_4fxFd",
          isCircularImage: true,
          content: [
            const TextSpan(text: 'Sophia Clark ', style: TextStyle(fontWeight: FontWeight.bold)),
            const TextSpan(text: 'replied to your post about local events', style: TextStyle(fontWeight: FontWeight.normal, color: AppTheme.textSecondary)),
          ],
          timeAgo: '5h ago',
          trailingIcon: Icons.comment,
          iconColor: AppTheme.primaryColor,
        ),
      ],
    ),
  ];

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