import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://rest-api-berita.vercel.app/api/v1';

  // Token management
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Register
  static Future<Map<String, dynamic>> register(Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
  }

  // Login
  static Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return jsonDecode(response.body);
  }

  // Get All Articles
  static Future<Map<String, dynamic>> getArticles({int page = 1, int limit = 10, String? category}) async {
    final url = Uri.parse('$baseUrl/news?page=$page&limit=$limit${category != null ? '&category=$category' : ''}');
    final response = await http.get(url);
    return jsonDecode(response.body);
  }

  // Get Article by ID
  static Future<Map<String, dynamic>> getArticleById(String id) async {
    final url = Uri.parse('$baseUrl/news/$id');
    final response = await http.get(url);
    return jsonDecode(response.body);
  }

  // Get Trending Articles
  static Future<Map<String, dynamic>> getTrendingArticles({int page = 1, int limit = 5}) async {
    final url = Uri.parse('$baseUrl/news/trending?page=$page&limit=$limit');
    final response = await http.get(url);
    return jsonDecode(response.body);
  }

  // Create Article
  static Future<Map<String, dynamic>> createArticle(Map<String, dynamic> data) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/news'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
  }

  // Update Article
  static Future<Map<String, dynamic>> updateArticle(String id, Map<String, dynamic> data) async {
    final token = await getToken();
    final response = await http.put(
      Uri.parse('$baseUrl/news/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    return jsonDecode(response.body);
  }

  // Delete Article
  static Future<Map<String, dynamic>> deleteArticle(String id) async {
    final token = await getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/news/$id'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return jsonDecode(response.body);
  }

  // Bookmark Article
  static Future<Map<String, dynamic>> saveBookmark(String id) async {
    final token = await getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/news/$id/bookmark'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return jsonDecode(response.body);
  }

  // Remove Bookmark
  static Future<Map<String, dynamic>> removeBookmark(String id) async {
    final token = await getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/news/$id/bookmark'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return jsonDecode(response.body);
  }

  // Check Bookmark
  static Future<Map<String, dynamic>> checkBookmark(String id) async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/news/$id/bookmark'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return jsonDecode(response.body);
  }

  // Get Bookmarked Articles
  static Future<Map<String, dynamic>> getBookmarks() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/news/bookmarks/list'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return jsonDecode(response.body);
  }

  // Get User's Articles
  static Future<Map<String, dynamic>> getUserArticles() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/news/user/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return jsonDecode(response.body);
  }
}