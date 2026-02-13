import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'courseapplypage.dart'; // Add this import

class CourseDetailPage extends StatefulWidget {
  final int courseId;
  final String? courseTitle;
  final double? amount;
  const CourseDetailPage({
    super.key,
    required this.courseId,
    this.courseTitle,
    this.amount, String? name,
  });

  @override
  State<CourseDetailPage> createState() => CourseDetailPageState();
}

class CourseDetailPageState extends State<CourseDetailPage> {
  Map? course;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchCourse();
  }

  Future<void> fetchCourse() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });
      final response = await http.get(
        Uri.parse('https://rks2ql97-3010.inc1.devtunnels.ms/courses/${widget.courseId}'),
            
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          course = Map<String, dynamic>.from(data);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = 'Course not found (${response.statusCode})';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'Network error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseTitle ?? 'Course ${widget.courseId}'),
        backgroundColor: Colors.blue.shade400,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading...'),
          ],
        ),
      )
          : errorMessage != null
          ? Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error,
                size: 80,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: fetchCourse,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown,
                ),
              ),
            ],
          ),
        ),
      )
          : course == null
          ? const Center(child: Text('No course data'))
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: course!['image']?.toString().isNotEmpty == true
                      ? Image.asset(
                    course!['image'],
                    fit: BoxFit.fitWidth,
                  )
                      : Container(
                    child: const Icon(
                      Icons.image_not_supported,
                      color: Colors.grey,
                      size: 90,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              course!['title']?.toString() ?? widget.courseTitle ?? 'Untitled',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '₹${course!['price'] ?? widget.amount?.toStringAsFixed(0) ?? '0'}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Text(
                course!['description']?.toString() ?? 'No description',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Center(
              child: SizedBox(
                width: 150,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseApplyPage(
                          name: course!['title']?.toString() ?? widget.courseTitle ?? 'Course',
                          amount: int.parse((course!['price'] ?? widget.amount ?? 0).toString()),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send),
                  label: const Text('Apply Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}