import 'package:flutter/material.dart';

class OurStorySection extends StatelessWidget {
  OurStorySection({super.key});

  final List<_StoryEvent> _events = [
    _StoryEvent(year: "2025", title: "Founded", detail: "Started in Tamil Nadu to help SMEs go digital.", icon: Icons.rocket_launch),
    _StoryEvent(year: "2026", title: "Scale Up", detail: "Scaled service delivery with a quality-first culture.", icon: Icons.trending_up),
    _StoryEvent(year: "2027", title: "Products Launch", detail: "Released two SaaS tools for mobile commerce & analytics.", icon: Icons.inventory_2),
    _StoryEvent(year: "2028", title: "Global Footprint", detail: "Serving customers across 6 countries and counting.", icon: Icons.public),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          // Section Header
          Column(
            children: [
              Text(
                "OUR JOURNEY",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2,
                  color: Colors.blueAccent.shade700,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Our Story",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 12),
              Container(width: 40, height: 3, color: Colors.blueAccent),
            ],
          ),
          const SizedBox(height: 50),

          // Timeline List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _events.length,
            itemBuilder: (context, index) {
              return _buildTimelineItem(index);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(int index) {
    final e = _events[index];
    final isLast = index == _events.length - 1;

    return IntrinsicHeight(
      child: Row(
        children: [
          // Timeline indicator Column
          Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade700,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Icon(e.icon, color: Colors.white, size: 18),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent.shade700, Colors.blueAccent.withOpacity(0.0)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),

          // Content Card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 32),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      e.year,
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    e.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    e.detail,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: Colors.blueGrey.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StoryEvent {
  final String year;
  final String title;
  final String detail;
  final IconData icon;

  _StoryEvent({
    required this.year,
    required this.title,
    required this.detail,
    required this.icon,
  });
}