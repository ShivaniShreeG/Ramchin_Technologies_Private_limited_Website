import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: SelectableText(
            '''
Privacy Policy

Last Updated: 06-03-2026

1. Introduction

Ramchin Technologies Private Limited respects your privacy and is committed to protecting any information you provide while using our website.

This Privacy Policy explains how information may be collected and used when visitors access our website.

2. Information We Collect

Our website is primarily informational and does not require users to register or create accounts.

We may collect limited information when users voluntarily provide it, such as:

• Name
• Email address
• Message details when contacting us

We do not intentionally collect sensitive personal information through this website.

3. Technical Information

Like most websites, our hosting provider may automatically record certain technical information for operational and security purposes. This may include:

• Browser type
• Device type
• Date and time of access
• General website usage information

This information is not used to personally identify visitors.

4. Use of Information

Any information provided to us may be used only for the following purposes:

• Responding to inquiries or communication requests
• Providing information about our services
• Improving the functionality of our website
• Maintaining website security

We do not sell, rent, or trade visitor information.

5. Data Security

We take reasonable measures to protect the website and any information submitted through it. However, no internet transmission can be guaranteed to be completely secure.

6. Separate Policies for Products and Programs

Certain services, products, or programs offered by Ramchin Technologies may have their own specific privacy policies and terms. Those policies will apply when users access those services.

7. Changes to This Policy

We may update this Privacy Policy from time to time. Updates will be posted on this page with the revised date.

8. Contact Information

Ramchin Technologies Private Limited  
Email: info@ramchintech.com  
Website: https://www.ramchintech.com
'''
        ),
      ),
    );
  }
}