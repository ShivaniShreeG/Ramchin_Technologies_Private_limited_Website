import 'package:flutter/material.dart';

class TermItem extends StatelessWidget {
  final String text;
  const TermItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_outline,
              color: Colors.blue, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown.shade50,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade400,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Terms & Conditions",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "By accessing or using our services, you agree to the following terms:",
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 30),
            const TermItem(
                text:
                "You must be at least 18 years old to register."),
            const TermItem(
                text:
                "Subscription is monthly and billed in INR."),
            const TermItem(
                text:
                "No refunds will be provided after a course has been accessed."),
            const TermItem(
                text:
                "Content is for personal educational use only."),
            const TermItem(
                text:
                "Ramchin Technologies holds the right to update or modify courses."),
            const SizedBox(height: 24),
            Text(
              "Please read all our policies carefully before proceeding.",
              style: TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}