import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms of Use")),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: SelectableText(
            '''
Terms of Use

Last Updated: 06-03-2026

1. Acceptance of Terms

By accessing and using the website of Ramchin Technologies Private Limited, you agree to comply with these Terms of Use.

2. Website Purpose

This website is provided for general informational purposes regarding the company, its services, products, and programs.

Information on this website may change without prior notice.

3. Intellectual Property

All content on this website, including but not limited to:

• text
• logos
• graphics
• design
• documents

is the property of Ramchin Technologies Private Limited unless otherwise stated.

You may not copy, reproduce, distribute, or modify website content without prior written permission.

4. Acceptable Use

Users agree not to:

• Use the website for unlawful purposes
• Attempt to gain unauthorized access to systems or data
• Disrupt or interfere with website functionality
• Upload or distribute malicious software

5. Separate Terms for Services

Certain products, services, internships, or training programs may have separate terms and policies that apply specifically to those offerings.

6. Governing Law

These Terms of Use shall be governed by and interpreted according to the laws of India.

7. Contact

Ramchin Technologies Private Limited  
Email: info@ramchintech.com  
Website: https://www.ramchintech.com
'''
        ),
      ),
    );
  }
}