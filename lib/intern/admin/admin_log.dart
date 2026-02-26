import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../old_pages/Home/admindash.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  AdminLoginPageState createState() => AdminLoginPageState();
}

class AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  bool isLoading = false;
  bool isPasswordVisible = false;

  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3010/admin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': usernameController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonRes = json.decode(response.body);
        if (jsonRes['success'] == true) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          if (!mounted) return;

          // 🔥 FIXED: Go to AdminLandingPage and STAY there
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const AdminLandingPage()),
          );
          return;
        }
        setState(() => errorMessage = 'Invalid username or password');
      } else {
        setState(() => errorMessage = 'Error: ${response.statusCode}');
      }
    } catch (e) {
      setState(() => errorMessage = 'Network Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 450),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 40),
                  Image.asset('ramchin.png', fit: BoxFit.contain),
                  const SizedBox(height: 26),
                  const Text(
                    'ADMIN',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: usernameController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: passwordController,
                    cursorColor: Colors.black,
                    obscureText: !isPasswordVisible,
                    decoration: InputDecoration(
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: Colors.black),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () =>
                            setState(() => isPasswordVisible = !isPasswordVisible),
                      ),
                    ),
                  ),
                  const SizedBox(height: 27),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.brown,
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      )
                          : const Text(
                        'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  if (errorMessage.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        errorMessage,
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AdminLandingPage extends StatefulWidget {
  const AdminLandingPage({super.key});
  @override
  State<AdminLandingPage> createState() => _AdminLandingPageState();
}

class _AdminLandingPageState extends State<AdminLandingPage> {
  Future<void> createCourse(
      String title, double price, String? image, String? description) async {
    try {
      final response = await http.post(
        Uri.parse('https://rks2ql97-3010.inc1.devtunnels.ms/courses'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'title': title,
          'price': price,
          'image': image,
          'description': description,
        }),
      );
      if (response.statusCode == 201) {
        // 🔥 FIXED: SHOW NOTIFICATION AND STAY ON THIS PAGE
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Course created successfully!')),
        );
        // 🔥 DON'T NAVIGATE AWAY - STAY HERE
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to create course')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network Error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('ramchin.png', height: 100, fit: BoxFit.contain),
              const SizedBox(height: 40),
              const Text(
                'ADMIN PANEL',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              const SizedBox(height: 60),
              SizedBox(
                width: 280,
                child: ElevatedButton.icon(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) =>
                        CourseCreateDialog(onCreate: createCourse),
                  ),
                  icon: const Icon(Icons.add_circle_outline, size: 28),
                  label: const Text(
                    'Create Course',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 280,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AdminDashboard(),
                    ),
                  ),
                  icon: const Icon(Icons.dashboard, size: 28),
                  label: const Text(
                    'Dashboard',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CourseCreateDialog extends StatefulWidget {
  final Function(String, double, String?, String?) onCreate;
  const CourseCreateDialog({super.key, required this.onCreate});
  @override
  State<CourseCreateDialog> createState() => _CourseCreateDialogState();
}

class _CourseCreateDialogState extends State<CourseCreateDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      constraints: BoxConstraints(
        minWidth: 450,
      ),
      title: const Text('Create New Course'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Course Title',
                  prefixIcon: Icon(Icons.title),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value?.isEmpty ?? true ? 'Enter course title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Price',
                  prefixIcon: Icon(Icons.currency_rupee),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Enter price';
                  final price = double.tryParse(value!);
                  return price != null && price > 0
                      ? null
                      : 'Valid price required';
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: imageController,
                decoration: const InputDecoration(
                  labelText: 'Image Filename (e.g., flutter.png)',
                  helperText: 'Place images in assets/logos/',
                  prefixIcon: Icon(Icons.image),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Course Description',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.description),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onCreate(
                titleController.text.trim(),
                double.parse(priceController.text.trim()),
                imageController.text.trim().isEmpty
                    ? null
                    : imageController.text.trim(),
                descriptionController.text.trim(),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Create Course'),
        ),
      ],
    );
  }
}