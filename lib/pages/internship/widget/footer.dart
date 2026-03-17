import 'package:flutter/material.dart';
import 'terms_condition.dart';
import 'privacy_policy.dart';

class InternshipFooter extends StatelessWidget {
  final VoidCallback onContactTap;

  const InternshipFooter({
    super.key,
    required this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      color: const Color(0xFF0F172A),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 30,
            runSpacing: 10,
            children: [
              TextButton(
                onPressed: onContactTap,
                child: const Text(
                  "Contact",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TermsConditionsPage(),
                    ),
                  );
                },
                child: const Text(
                  "Terms & Conditions",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PrivacyPolicyPage(),
                    ),
                  );
                },
                child: const Text(
                  "Privacy Policy",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "© 2026 Your Company Name. All rights reserved.",
            style: TextStyle(
              color: Colors.white54,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}