import 'package:flutter/material.dart';

class OurStorySection extends StatelessWidget {
  OurStorySection({super.key});

  final List<_StoryEvent> _events = [
    _StoryEvent(
      year: "2025",
      title: "The Genesis",
      detail: "Ramchin Technologies was founded in Tamil Nadu with a vision to bridge the digital divide for SMEs through cutting-edge architecture.",
      icon: Icons.auto_awesome_rounded,
    ),
    _StoryEvent(
      year: "2025 – 2026",
      title: "Building Trust",
      detail: "Successfully onboarded our first five enterprise partners, setting a standard for reliability and agile software delivery.",
      icon: Icons.handshake_rounded,
    ),
    _StoryEvent(
      year: "2026",
      title: "Global Footprint",
      detail: "Scaled to the Google Play Store with 3 production-grade apps, validating our technical stack in real-world environments.",
      icon: Icons.language_rounded,
    ),
    _StoryEvent(
      year: "2026 – 2027",
      title: "Product Evolution",
      detail: "Expanding our ecosystem with 4 new high-performance mobile applications currently in the final stages of CI/CD deployment.",
      icon: Icons.layers_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 950;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [const Color(0xFFF8FAFC), Colors.white.withOpacity(0.5)],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? size.width * 0.1 : 24,
        vertical: 48,
      ),
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 36),
          // We use a Column to maintain the vertical flow
          ..._events.asMap().entries.map((entry) {
            return _buildStoryNode(entry.value, entry.key, isWide, entry.key == _events.length - 1);
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.08),
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            "OUR JOURNEY",
            style: TextStyle(
              color: Colors.blueAccent.shade700,
              fontWeight: FontWeight.w800,
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "The Evolution of Ramchin",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w900,
            color: Color(0xFF0F172A),
            letterSpacing: -1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStoryNode(_StoryEvent event, int index, bool isWide, bool isLast) {
    // Determine side: 0 = Right, 1 = Left
    bool isLeft = isWide && index % 2 != 0;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left side spacer or content
          if (isWide) Expanded(child: isLeft ? _StoryCard(event: event) : const SizedBox()),

          // Timeline Path
          SizedBox(
            width: isWide ? 80 : 50,
            child: Column(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blueAccent, width: 3),
                    boxShadow: [
                      BoxShadow(color: Colors.blueAccent.withOpacity(0.2), blurRadius: 10)
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
                    ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blueAccent, Colors.blueAccent.withOpacity(0.0)],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Right side content
          Expanded(
            child: isWide
                ? (isLeft ? const SizedBox() : _StoryCard(event: event))
                : _StoryCard(event: event, isMobile: true),
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends StatefulWidget {
  final _StoryEvent event;
  final bool isMobile;
  const _StoryCard({required this.event, this.isMobile = false});

  @override
  State<_StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<_StoryCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: widget.isMobile ? 40 : 60),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isHovered ? Colors.blueAccent.withOpacity(0.3) : Colors.grey.shade100,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered ? Colors.blueAccent.withOpacity(0.08) : Colors.black.withOpacity(0.02),
              blurRadius: isHovered ? 30 : 15,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(widget.event.icon, size: 20, color: Colors.blueAccent),
                const SizedBox(width: 12),
                Text(
                  widget.event.year,
                  style: TextStyle(
                    color: Colors.blueAccent.shade700,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              widget.event.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B),
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.event.detail,
              style: TextStyle(
                fontSize: 15,
                height: 1.6,
                color: Colors.blueGrey.shade500,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryEvent {
  final String year;
  final String title;
  final String detail;
  final IconData icon;
  _StoryEvent({required this.year, required this.title, required this.detail, required this.icon});
}