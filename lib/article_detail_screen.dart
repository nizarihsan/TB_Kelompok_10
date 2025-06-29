import 'package:flutter/material.dart';
import 'services/api_service.dart';
import 'models/article.dart';

class ArticleDetailScreen extends StatefulWidget {
  final String articleId;
  const ArticleDetailScreen({super.key, required this.articleId});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  Article? _article;
  bool _isLoading = true;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    fetchDetail();
    checkBookmark();
  }

  void fetchDetail() async {
    final result = await ApiService.getArticleById(widget.articleId);
    setState(() {
      _article = Article.fromJson(result['data']);
      _isLoading = false;
    });
  }

  void checkBookmark() async {
    final result = await ApiService.checkBookmark(widget.articleId);
    setState(() {
      _isBookmarked = result['data']['isSaved'] ?? false;
    });
  }

  void toggleBookmark() async {
    if (_isBookmarked) {
      await ApiService.removeBookmark(widget.articleId);
    } else {
      await ApiService.saveBookmark(widget.articleId);
    }
    checkBookmark();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_article == null) return const Center(child: Text('Article not found'));
    // Tampilkan detail artikel
    return Scaffold(
      appBar: AppBar(
        title: Text(_article!.title),
        actions: [
          IconButton(
            icon: Icon(
                _isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: toggleBookmark,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(_article!.content),
      ),
    );
  }
}