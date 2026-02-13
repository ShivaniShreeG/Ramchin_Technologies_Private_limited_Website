import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'pages/homepage.dart';
import 'admin/admin_log.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Courses',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.brown.shade50,
        fontFamily: 'Roboto',
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const InternshipPage(),  // Direct to HomePage - NO splash
      routes: {
        '/home': (context) => const InternshipPage(),
        '/admin': (context) => const AdminLoginPage(),
      },
    );
  }
}


class AdminLoginButton extends StatelessWidget {
  const AdminLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SizedBox(
        width: 200,
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, '/admin');
          },
          icon: const Icon(Icons.admin_panel_settings, size: 24),
          label: const Text(
            'Admin Login',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown.shade700,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            elevation: 8,
          ),
        ),
      ),
    );
  }
}