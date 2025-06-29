import 'package:flutter/material.dart';
import 'models/article.dart';
import 'services/api_service.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(_article!.title),
        actions: [
          IconButton(
            icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
            onPressed: toggleBookmark,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Image.network(_article!.imageUrl, fit: BoxFit.cover),
          const SizedBox(height: 16),
          Text(_article!.title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(
              '${_article!.category} • ${_article!.publishedAt} • ${_article!.readTime}'),
          const SizedBox(height: 16),
          Text(_article!.content),
          const SizedBox(height: 24),
          ListTile(
            leading: CircleAvatar(
                backgroundImage: NetworkImage(_article!.author.avatar)),
            title: Text(_article!.author.name),
            subtitle: Text(_article!.author.title),
          ),
        ],
      ),
    );
  }
}