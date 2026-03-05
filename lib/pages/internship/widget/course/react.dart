import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReactPage extends StatelessWidget {
  const ReactPage({super.key});

  final String courseName = "React";
  final String amount = "3,000";

  @override
  Widget build(BuildContext context) {
    const primaryBrand = Color(0xFF02539A);
    const secondaryBrand = Color(0xFF00B4D8);
    const backgroundNavy = Color(0xFF0F172A);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [

          // 1️⃣ HERO HEADER
          SliverAppBar(
            expandedHeight: 320,
            pinned: true,
            stretch: true,
            backgroundColor: backgroundNavy,
            leading: _buildBackButton(context),
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.blurBackground
              ],
              background: Stack(
                fit: StackFit.expand,
                children: [

                  // Gradient Background
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [backgroundNavy, primaryBrand],                      ),
                    ),
                  ),

                  // Big Background Logo
                  Positioned(
                    right: -20,
                    bottom: 20,
                    child: FaIcon(
                      FontAwesomeIcons.react,
                      color: Colors.white.withValues(alpha:0.05),
                      size: 240,
                    ),
                  ),

                  // Center Logo with Glow
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: secondaryBrand.withValues(alpha:0.4),
                            blurRadius: 40,
                            spreadRadius: 10,
                          )
                        ],
                      ),
                      child: const FaIcon(
                        FontAwesomeIcons.react,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 2️⃣ FLOATING CONTENT
          SliverToBoxAdapter(
            child: Transform.translate(
              offset: const Offset(0, -40),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha:0.08),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const SizedBox(height: 40),

                      // Stats Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildStatItem(Icons.timer_rounded, "1 Month", "Intensive", secondaryBrand),
                          _buildStatItem(Icons.payments_rounded, "₹$amount", "Total Fee", Colors.green),
                          _buildStatItem(Icons.public_rounded, "Live", "Projects", Colors.orange),
                        ],
                      ),

                      const Divider(height: 48, thickness: 1),

                      // ABOUT
                      _sectionHeader("The Curriculum"),
                      const Text(
                        "Master modern web development with React. Build dynamic SPAs, integrate APIs, and deploy production-ready applications.",
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.6,
                          color: Color(0xFF64748B),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // TIMELINE
                      _buildEnhancedTimeline([
                        _TimelineData("01", "Web Foundations", "HTML, CSS, JavaScript ES6+", true),
                        _TimelineData("02", "React Core", "Components, Props, State", true),
                        _TimelineData("03", "Advanced React", "Hooks, Routing, API Integration", true),
                        _TimelineData("04", "Deployment", "Optimization & Hosting", false),
                      ], primaryBrand),

                      const SizedBox(height: 40),

                      // PROJECT
                      _buildProjectCard(primaryBrand),

                      const SizedBox(height: 24),

                      // CERTIFICATE
                      _buildCertificateCard(primaryBrand),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- WIDGETS ---

  Widget _buildBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha:0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded,
            color: Colors.white, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildStatItem(
      IconData icon, String value, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration:
          BoxDecoration(color: color.withValues(alpha:0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 12),
        Text(value,
            style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: Color(0xFF1E293B))),
        Text(label,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: Color(0xFF0F172A),
          letterSpacing: -0.5),
    );
  }

  Widget _buildEnhancedTimeline(List<_TimelineData> data, Color color) {
    return Column(
      children: data.map((item) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: color.withValues(alpha:0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Text(item.num,
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                if (item.showLine)
                  Container(
                    width: 2,
                    height: 60,
                    decoration: BoxDecoration(
                        color: color.withValues(alpha:0.1),
                        borderRadius: BorderRadius.circular(2)),
                  ),
              ],
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B))),
                  const SizedBox(height: 4),
                  Text(item.subtitle,
                      style: const TextStyle(
                          color: Color(0xFF64748B), fontSize: 14)),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildProjectCard(Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [color, color.withBlue(180)]),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: const [
          Icon(Icons.rocket_launch_rounded, color: Colors.white, size: 40),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Capstone Project",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text("Build a Production-Ready Web App",
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificateCard(Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Column(
        children: [
          Icon(Icons.verified_rounded, color: color, size: 32),
          const SizedBox(height: 12),
          const Text("Industry-Recognized Certificate",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}

class _TimelineData {
  final String num, title, subtitle;
  final bool showLine;
  _TimelineData(this.num, this.title, this.subtitle, this.showLine);
}