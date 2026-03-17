import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Privacy Policy",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.primaryColor,
                    theme.primaryColor.withValues(alpha: 0.8)
                  ],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Legal Information",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Last Updated: March 06, 2026",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSectionCard(
                    context,
                    "1. Introduction",
                    "Ramchin Technologies Private Limited respects your privacy and is committed to protecting any information you provide while using our website.\n\nThis Privacy Policy explains how information may be collected and used when visitors access our website.",
                    Icons.privacy_tip_outlined,
                  ),
                  _buildSectionCard(
                    context,
                    "2. Information We Collect",
                    "Our website is primarily informational and does not require users to register or create accounts.\n\nWe may collect limited information when users voluntarily provide it, such as:\n\n"
                        "• Name\n"
                        "• Email address\n"
                        "• Message details when contacting us\n\n"
                        "We do not intentionally collect sensitive personal information through this website.",
                    Icons.person_outline,
                  ),
                  _buildSectionCard(
                    context,
                    "3. Technical Information",
                    "Like most websites, our hosting provider may automatically record certain technical information for operational and security purposes. This may include:\n\n"
                        "• Browser type\n"
                        "• Device type\n"
                        "• Date and time of access\n"
                        "• General website usage information\n\n"
                        "This information is not used to personally identify visitors.",
                    Icons.computer_outlined,
                  ),
                  _buildSectionCard(
                    context,
                    "4. Use of Information",
                    "Any information provided to us may be used only for the following purposes:\n\n"
                        "• Responding to inquiries or communication requests\n"
                        "• Providing information about our services\n"
                        "• Improving the functionality of our website\n"
                        "• Maintaining website security\n\n"
                        "We do not sell, rent, or trade visitor information.",
                    Icons.settings_outlined,
                  ),
                  _buildSectionCard(
                    context,
                    "5. Data Security",
                    "We take reasonable measures to protect the website and any information submitted through it. However, no internet transmission can be guaranteed to be completely secure.",
                    Icons.security_outlined,
                  ),
                  _buildSectionCard(
                    context,
                    "6. Separate Policies",
                    "Certain services, products, or programs offered by Ramchin Technologies may have their own specific privacy policies and terms. Those policies will apply when users access those services.",
                    Icons.description_outlined,
                  ),
                  _buildSectionCard(
                    context,
                    "7. Changes to This Policy",
                    "We may update this Privacy Policy from time to time. Updates will be posted on this page with the revised date.",
                    Icons.update_outlined,
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),

                  const Text(
                    "Contact Information",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

  Widget _buildSectionCard(
      BuildContext context, String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Theme.of(context).primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
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