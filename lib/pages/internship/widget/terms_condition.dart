import 'package:flutter/material.dart';

class TermsConditionsPage extends StatefulWidget {
  const TermsConditionsPage({super.key});

  @override
  State<TermsConditionsPage> createState() => _TermsConditionsPageState();
}

class _TermsConditionsPageState extends State<TermsConditionsPage> {
  final ScrollController _scrollController = ScrollController();
  double _readProgress = 0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _readProgress = _scrollController.offset / _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Lighter Slate
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 60),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha:0.08),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDocumentHeader(),
                      const Divider(height: 60, thickness: 1),
                      _buildSection(
                        "01",
                        "Age Requirement",
                        "You must be at least 18 years old to register and use our services.",
                        Icons.person_outline,
                      ),

                      _buildSection(
                        "02",
                        "Subscription & Billing",
                        "Subscription is monthly and all payments are billed in INR through secure payment gateways.",
                        Icons.payments_outlined,
                      ),

                      _buildSection(
                        "03",
                        "Refund Policy",
                        "No refunds will be provided after a course has been accessed under any circumstances.",
                        Icons.money_off_csred_outlined,
                      ),

                      _buildSection(
                        "04",
                        "Usage Policy",
                        "All content provided by Ramchin Technologies is strictly for personal educational use only and cannot be redistributed or resold.",
                        Icons.lock_outline_rounded,
                      ),

                      _buildSection(
                        "05",
                        "Rights & Modifications",
                        "Ramchin Technologies reserves the right to update, modify, or remove courses and policies at any time without prior notice.",
                        Icons.update_rounded,
                      ),

                      const SizedBox(height: 40),
                      _buildContactFooter(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _buildFrostedNavBar(context),
        ],
      ),
    );
  }

  Widget _buildDocumentHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "SERVICE AGREEMENT",
          style: TextStyle(
            color: Color(0xFF4F46E5),
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Terms & Conditions",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w900,
            color: Color(0xFF1E293B),
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.history, size: 16, color: Colors.grey),
            const SizedBox(width: 6),
            Text(
              "Effective: March 03, 2026",
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection(String number, String title, String body, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w900,
              color: Colors.blue.shade200,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(icon, size: 20, color: const Color(0xFF4F46E5)),
                    const SizedBox(width: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  body,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.7,
                    color: Color(0xFF475569),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFrostedNavBar(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.only(top: 50, bottom: 15, left: 20, right: 20),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha:0.9),
          border: const Border(bottom: BorderSide(color: Colors.black12)),
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Color(0xFF1E293B)),
            ),
            const Spacer(),
            // READ PROGRESS BAR
            Container(
              width: 100,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: _readProgress.clamp(0.0, 1.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            const Text(
              "READING",
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContactFooter() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          Icon(Icons.mail_outline, color: Color(0xFF4F46E5)),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              "Queries? ramchintech@gmail.com",
              style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
            ),
          ),
        ],
      ),
    );
  }
}