import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'services/api_service.dart';
import 'home_screen.dart'; // Import HomeScreen

// Bagian 1: Definisi Tema Aplikasi
class AppTheme {
  static const Color primaryColor = Color(0xFFB2CAE5);
  static const Color secondaryColor = Color(0xFF121416);
  static const Color accentColor = Color(0xFF6A7581);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color inputBackgroundColor = Color(0xFFF1F2F4);
  static const Color inputBorderColor = Color(0xFFD1D5DB); // border-gray-300
}

// Bagian 2: Widget Utama Halaman Sign Up
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final avatarController = TextEditingController();
  bool isLoading = false;

  bool _obscurePassword = true; // Tambahkan ini
  bool _obscureConfirmPassword = true; // Tambahkan ini

  void handleRegister() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password and confirmation do not match')),
      );
      return;
    }
    setState(() => isLoading = true);
    final result = await ApiService.register({
      "email": emailController.text,
      "password": passwordController.text,
      "name": nameController.text.isEmpty ? "User" : nameController.text,
      "title": titleController.text.isEmpty ? "User" : titleController.text,
      "avatar": avatarController.text.isEmpty
          ? "https://ui-avatars.com/api/?name=User"
          : avatarController.text,
    });
    setState(() => isLoading = false);

    if (result['success'] == true) {
      await ApiService.saveToken(result['data']['token']);
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result['message'] ?? 'Register failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FBFD),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FBFD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
        centerTitle: true,
        title: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Create your account',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 32),
            // Email
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE9EEF3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.mail_outline, color: Color(0xFF4B6478)),
                  hintText: 'Email',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Password
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE9EEF3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF4B6478)),
                  hintText: 'Password',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF4B6478),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Confirm Password
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE9EEF3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF4B6478)),
                  hintText: 'Confirm Password',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF4B6478),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
            ),
            // Optional: Name, Title, Avatar (hidden, or you can show as needed)
            // TextField(controller: nameController, decoration: InputDecoration(hintText: 'Name')),
            // TextField(controller: titleController, decoration: InputDecoration(hintText: 'Title')),
            // TextField(controller: avatarController, decoration: InputDecoration(hintText: 'Avatar URL')),
            const SizedBox(height: 32),
            // Sign Up Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A84FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                onPressed: isLoading ? null : handleRegister,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Sign up',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
              ),
            ),
            const Spacer(),
            // Sign in link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account? ",
                  style: TextStyle(color: Color(0xFF4B6478)),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      color: Color(0xFF0A84FF),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}