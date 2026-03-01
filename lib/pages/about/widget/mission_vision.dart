import 'package:flutter/material.dart';

class MissionVisionSection extends StatelessWidget {
  const MissionVisionSection({super.key});
  static const String missionContent =
      "To empower businesses worldwide by providing innovative, scalable, and efficient software solutions that drive transformation and enhance productivity. We strive to be a trusted partner, nurturing creativity while making a positive impact in the global tech ecosystem.";

  static const String visionContent =
      "To deliver tailored software solutions that empower businesses to thrive in a rapidly evolving digital world. By prioritizing quality and collaboration, we aim to transform ideas into powerful tools, ensuring efficiency and measurable success for our clients.";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 1100;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? size.width * 0.08 : 24,
        vertical: isWide ? 44 : 32,
      ),
      child: Column(
        children: [
          _buildEliteHeader(isWide),
          const SizedBox(height: 40),
          _buildContentGrid(isWide),
        ],
      ),
    );
  }

  Widget _buildEliteHeader(bool isWide) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            "CORE ARCHITECTURE",
            style: TextStyle(
              color: Colors.blueAccent.shade700,
              fontWeight: FontWeight.w800,
              fontSize: 11,
              letterSpacing: 2.0,
            ),
          ),
        ),
            const SizedBox(height: 24), // was 32
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: isWide ? 64 : 40,
              color: const Color(0xFF101828),
              letterSpacing: -2.5,
              height: 0.95, // was 1.0
            ),
            children: [
              const TextSpan(
                text: "Defining our ",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              const TextSpan(
                text: "Purpose",
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContentGrid(bool isWide) {
    return isWide
        ? IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: _buildPerspectiveCard(
              title: "Our Mission",
              subtitle: "THE EXECUTION",
              icon: Icons.rocket_launch_rounded,
              isPrimary: true,
              content:missionContent
            ),
          ),
          const SizedBox(width: 50),
          Expanded(
            child: _buildPerspectiveCard(
              title: "Our Vision",
              subtitle: "THE FUTURE",
              icon: Icons.remove_red_eye_rounded,
              isPrimary: false,
              content:visionContent
            ),
          ),
        ],
      ),
    )
        : Column(
      children: [
        _buildPerspectiveCard(
          title: "Our Mission",
          subtitle: "THE EXECUTION",
          icon: Icons.rocket_launch_rounded,
          isPrimary: true,
          content: missionContent,
        ),
        const SizedBox(height: 40),
        _buildPerspectiveCard(
          title: "Our Vision",
          subtitle: "THE FUTURE",
          icon: Icons.remove_red_eye_rounded,
          isPrimary: false,
          content: visionContent,
        ),
      ],
    );
  }

  Widget _buildPerspectiveCard({
    required String title,
    required String subtitle,
    required String content,
    required IconData icon,
    required bool isPrimary,
  }) {
    final bgColor = isPrimary ? const Color(0xFF101828) : Colors.white;
    final textColor = isPrimary ? Colors.white : const Color(0xFF101828);

    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: isPrimary ? null : Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: isPrimary ? Colors.blueAccent.withValues(alpha: 0.15) : Colors.black.withValues(alpha: 0.03),
            blurRadius: 50,
            offset: const Offset(0, 30),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subtitle,
                style: TextStyle(
                  color: isPrimary ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 12,
                  letterSpacing: 2.0,
                ),
              ),
              Icon(
                icon,
                size: 40,
                color: isPrimary
                    ? Colors.white // primary card icon
                    : Colors.black, // secondary card icon
              ),
            ],
          ),
          const SizedBox(height: 40),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 36,
              fontWeight: FontWeight.w900,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            content,
            style: TextStyle(
              color: isPrimary ? Colors.blueGrey.shade100 : const Color(0xFF475467),
              fontSize: 18,
              height: 1.8,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}