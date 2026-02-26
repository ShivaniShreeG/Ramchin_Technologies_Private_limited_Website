import 'package:flutter/material.dart';

class FutureGoalsSection extends StatelessWidget {
  FutureGoalsSection({super.key});

  final List<Map<String, dynamic>> _futureGoals = [
    {"goal": "Vertical SaaS", "desc": "Launch two vertical SaaS products for SMEs.", "icon": Icons.rocket_launch},
    {"goal": "Regional Expansion", "desc": "Expand engineering hubs across South Asia.", "icon": Icons.public},
    {"goal": "Security Standards", "desc": "Achieve ISO/IEC security certifications.", "icon": Icons.verified_user},
    {"goal": "R&D Investment", "desc": "Invest in R&D for AI-powered automation.", "icon": Icons.psychology},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Left aligned for a professional feel
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 28,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Future Goals",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                  color: Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildGoalsGrid(context),
        ],
      ),
    );
  }

  Widget _buildGoalsGrid(BuildContext context) {
    return Column(
      children: _futureGoals.map((item) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item['icon'], color: Colors.blueAccent, size: 22),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['goal'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['desc'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}