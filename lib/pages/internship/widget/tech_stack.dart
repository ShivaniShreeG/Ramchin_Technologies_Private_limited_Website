import 'package:flutter/material.dart';

class TechStack extends StatelessWidget {
  const TechStack({super.key});

  final List<Map<String, dynamic>> techStack = const [
    {"name": "Flutter", "icon": "https://www.ramchintech.com/companyweb/Icon/1772637232672-883463208.png", "color": Colors.blue, "desc": "Build Android & Web Apps"},
    {"name": "React", "icon": "https://www.ramchintech.com/companyweb/Icon/1772637262645-426500600.png", "color": Colors.cyan, "desc": "Modern Web Frontend"},
    {"name": "React Native", "icon": "https://www.ramchintech.com/companyweb/Icon/1772637262645-426500600.png", "color": Colors.blueAccent, "desc": "Cross-Platform Mobile Apps"},
    {"name": "Angular", "icon": "https://www.ramchintech.com/companyweb/Icon/1772637225631-33144048.png", "color": Colors.red, "desc": "Enterprise Web Apps"},
    {"name": "Node.js", "icon": "https://www.ramchintech.com/companyweb/Icon/1772637247462-62460647.png", "color": Colors.green, "desc": "Server & API Development"},
    {"name": "MySQL", "icon": "https://www.ramchintech.com/companyweb/Icon/1772637241765-546254011.png", "color": Colors.orange, "desc": "Relational Database"},
    {"name": "Python", "icon": "https://www.ramchintech.com/companyweb/Icon/1772637256953-730800332.png", "color": Colors.yellow, "desc": "AI, Data Science & Backend"},
    {"name": "PHP", "icon": "https://www.ramchintech.com/companyweb/Icon/1772637252655-903121176.png", "color": Colors.indigo, "desc": "Dynamic Web Applications"},
  ];

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 60),

          LayoutBuilder(
            builder: (context, constraints) {

              double width = constraints.maxWidth;
              int crossAxisCount;

              if (width >= 1100) {
                crossAxisCount = 4;
              } else if (width >= 700) {
                crossAxisCount = 2;
              } else {
                crossAxisCount = 1;
              }

              const double cardWidth = 180;
              const double spacing = 20;

              double totalWidth =
                  (cardWidth * crossAxisCount) + (spacing * (crossAxisCount - 1));

              return Center(
                child: SizedBox(
                  width: totalWidth,
                  child: Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    alignment: WrapAlignment.center,
                    children:
                    techStack.map((tech) => TechTile(tech: tech)).toList(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Column(
      children: [
        const SizedBox(height: 10),

        Text(
          "Technologies You’ll Work With & Master",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: isMobile ? 26 : 40,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
          ),
        ),

        const SizedBox(height: 16),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: Text(
            "Gain hands-on experience with real-world technologies used by modern development teams. Build, deploy, and scale applications using industry-standard tools across frontend, backend, mobile, and databases.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 14 : 17,
              height: 1.6,
              color: Colors.grey,
            ),
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}

class TechTile extends StatefulWidget {
  final Map<String, dynamic> tech;
  const TechTile({super.key, required this.tech});

  @override
  State<TechTile> createState() => _TechTileState();
}

class _TechTileState extends State<TechTile> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 180,
        height: 180,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? widget.tech["color"].withValues(alpha:0.1) : Colors.grey.shade200,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? (widget.tech["color"] as Color).withValues(alpha:0.1)
                  : Colors.black.withValues(alpha:0.03),
              blurRadius: _isHovered ? 20 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60,
              width: 60,
              padding: const EdgeInsets.all(12),
              child: Image.network(widget.tech["icon"]!),
            ),
            const SizedBox(height: 16),
            Text(
              widget.tech["name"],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E293B)),
            ),
            const SizedBox(height: 4),
            Text(
              widget.tech["desc"],
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Colors.grey.withValues(alpha:0.8)),
            ),
          ],
        ),
      ),
    );
  }
}
