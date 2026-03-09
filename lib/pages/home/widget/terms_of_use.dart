import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50], // Subtle background contrast
      appBar: AppBar(
        title: const Text("Terms of Use", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [theme.primaryColor, theme.primaryColor.withValues(alpha:0.8)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Legal Agreement",
                    style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Terms of Use",
                    style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Last Updated: March 06, 2026",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                ],
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSectionCard(
                    context,
                    "1. Acceptance of Terms",
                    "By accessing and using the website of Ramchin Technologies Private Limited, you agree to comply with these Terms of Use.",
                    Icons.check_circle_outline,
                  ),
                  _buildSectionCard(
                    context,
                    "2. Website Purpose",
                    "This website is provided for general informational purposes regarding the company, its services, products, and programs.\n\nInformation on this website may change without prior notice.",
                    Icons.info_outline,
                  ),
                  _buildSectionCard(
                    context,
                    "3. Intellectual Property",
                    "All content on this website (text, logos, graphics, design, documents) is the property of Ramchin Technologies Private Limited unless otherwise stated.\n\nYou may not copy, reproduce, distribute, or modify website content without prior written permission.",
                    Icons.copyright,
                  ),
                  _buildSectionCard(
                    context,
                    "4. Acceptable Use",
                    "Users agree not to:\n\n"
                        "• Use the website for unlawful purposes\n"
                        "• Attempt to gain unauthorized access to systems or data\n"
                        "• Disrupt or interfere with website functionality\n"
                        "• Upload or distribute malicious software",
                    Icons.gpp_maybe,
                    isWarning: true,
                  ),
                  _buildSectionCard(
                    context,
                    "5. Separate Terms",
                    "Certain products, services, internships, or training programs may have separate terms and policies that apply specifically to those offerings.",
                    Icons.description_outlined,
                  ),
                  _buildSectionCard(
                    context,
                    "6. Governing Law",
                    "These Terms of Use shall be governed by and interpreted according to the laws of India.",
                    Icons.balance,
                  ),
                  // Footer Info
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),

                  const Text(
                    "Contact Us",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text("Ramchin Technologies Private Limited"),
                  TextButton(
                    onPressed: () {},
                    child: const Text("info@ramchintech.com"),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard(BuildContext context, String title, String content, IconData icon, {bool isWarning = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: isWarning ? Colors.orange : Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SelectableText(
              content,
              style: TextStyle(
                fontSize: 15,
                height: 1.5,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}