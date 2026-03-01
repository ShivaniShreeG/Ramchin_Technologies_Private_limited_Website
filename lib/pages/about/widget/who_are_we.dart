import 'package:flutter/material.dart';

class WhoWeAreSection extends StatelessWidget {
  const WhoWeAreSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 1000;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? size.width * 0.08 : 24,
        vertical: isWide ? 64 : 48,
      ),
      child: isWide
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 5, child: _buildImageSide(isWide)),
          const SizedBox(width: 80),
          Expanded(flex: 6, child: _buildContentSide(isWide)),
        ],
      )
          : Column(
        children: [
          _buildImageSide(isWide),
          const SizedBox(height: 60),
          _buildContentSide(isWide),
        ],
      ),
    );
  }

  Widget _buildContentSide(bool isWide) {
    return Column(
      crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        // Subtle tag
        Text(
          "ABOUT RAMCHIN",
          style: TextStyle(
            color: Colors.blueAccent.shade700,
            fontWeight: FontWeight.w800,
            fontSize: 13,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Who We Are",
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 64 : 42,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF101828),
            letterSpacing: -2,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 30),
        Container(
          width: 80,
          height: 5,
          color: Colors.blueAccent,
        ),
        const SizedBox(height: 40),
        Text(
          "Ramchin Technologies is a technology-driven product and services company enabling organizations to design, build, and scale high-impact digital solutions.",
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: const TextStyle(
            fontSize: 22,
            height: 1.6,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1D2939),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Founded with a clear vision to bridge innovation and execution, we work as a trusted technology partner—delivering reliable, secure, and scalable systems that drive measurable business outcomes and long-term growth.",
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            height: 1.8,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildImageSide(bool isWide) {
    return Stack(
      children: [
        // Main Image Placeholder
        Container(
          height: isWide ? 420 : 320,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(24),
            image: const DecorationImage(
              image: NetworkImage("https://www.ramchintech.com/companyweb/About_Us/1772171954635-565131107.png"), // Replace with your actual team/office image
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 30,
          left: -20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha:0.1),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "SINCE",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Colors.blue.shade300,
                    letterSpacing: 1.5,
                  ),
                ),
                const Text(
                  "2025",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF101828),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}