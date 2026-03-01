import 'package:flutter/material.dart';

class OurGoalsSection extends StatelessWidget {
  OurGoalsSection({super.key});

  final List<Map<String, dynamic>> _goals = [
    {"title": "First 5 Clients", "timeline": "Within 1 Year", "progress": 1.0, "target": 5, "current": 5, "icon": Icons.people_alt_rounded},
    {"title": "First 20 Clients", "timeline": "Within 2 Years", "progress": 0.5, "target": 20, "current": 10, "icon": Icons.group_add_rounded},
    {"title": "3 Apps Launched", "timeline": "Within 1 Year", "progress": 1.0, "target": 3, "current": 3, "icon": Icons.rocket_launch_rounded},
    {"title": "10 Apps Launched", "timeline": "Within 2 Years", "progress": 0.7, "target": 10, "current": 7, "icon": Icons.auto_awesome_motion_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isWide = size.width > 950;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC),
      padding: EdgeInsets.symmetric(
        horizontal: isWide ? size.width * 0.12 : 24,
        vertical: isWide ? 80 : 40,
      ),
      child: Column(
        children: [
          _buildEliteHeader(),
          const SizedBox(height: 50),
          isWide ? _buildGrid() : _buildList(),
        ],
      ),
    );
  }

  Widget _buildEliteHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Text(
            "COMPANY MILESTONES",
            style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w800, fontSize: 10, letterSpacing: 1.5),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "Our Strategic Roadmap",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Color(0xFF0F172A), letterSpacing: -1.5),
        ),
      ],
    );
  }

  Widget _buildGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 30,
        mainAxisExtent: 240,
      ),
      itemCount: _goals.length,
      itemBuilder: (context, index) => _GoalCard(goal: _goals[index]),
    );
  }

  Widget _buildList() => Column(children: _goals.map((g) => Padding(padding: const EdgeInsets.only(bottom: 20), child: _GoalCard(goal: g))).toList());
}

class _GoalCard extends StatefulWidget {
  final Map<String, dynamic> goal;
  const _GoalCard({required this.goal});

  @override
  State<_GoalCard> createState() => _GoalCardState();
}

class _GoalCardState extends State<_GoalCard> {
  bool isHovered = false;
  bool isProgressHovered = false;

  @override
  Widget build(BuildContext context) {
    final double progress = widget.goal['progress'];
    final bool isCompleted = progress >= 1.0;

    // Define status-based colors
    final Color activeColor = isCompleted ? const Color(0xFF16A34A) : const Color(0xFF2563EB);

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          // 👇 Border now matches the theme of the specific goal
          border: Border.all(
            color: isHovered
                ? activeColor.withValues(alpha: 0.5)
                : activeColor.withValues(alpha: 0.1), // Subtle border when not hovered
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isHovered
                  ? activeColor.withValues(alpha:0.12)
                  : Colors.black.withValues(alpha:0.03),
              blurRadius: isHovered ? 40 : 20,
              offset: isHovered ? const Offset(0, 15) : const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIconBadge(isCompleted),
                _StatusBadge(isCompleted: isCompleted),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    widget.goal['title'],
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF1E293B)
                    )
                ),
                const SizedBox(height: 4),
                Text(
                    widget.goal['timeline'],
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueGrey.shade400,
                        fontWeight: FontWeight.w500
                    )
                ),
              ],
            ),
            _buildModernProgress(progress, isCompleted, activeColor),
          ],
        ),
      ),
    );
  }

  Widget _buildIconBadge(bool isCompleted) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isCompleted ? const Color(0xFFDCFCE7) : const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(widget.goal['icon'], color: isCompleted ? const Color(0xFF16A34A) : Colors.blueAccent, size: 24),
    );
  }

  // Pass activeColor to the progress section to maintain consistency
  Widget _buildModernProgress(double progress, bool isCompleted, Color activeColor) {
    final int current = widget.goal['current'];
    final int target = widget.goal['target'];
    final int percentage = (progress * 100).round();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Progress", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF94A3B8))),
            Text("$current / $target", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: activeColor)),
          ],
        ),
        const SizedBox(height: 12),
        LayoutBuilder(
          builder: (context, constraints) {
            final fillWidth = constraints.maxWidth * progress;
            return MouseRegion(
              onEnter: (_) => setState(() => isProgressHovered = true),
              onExit: (_) => setState(() => isProgressHovered = false),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(height: 10, width: constraints.maxWidth, decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(10))),
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeOutCubic,
                    height: 10,
                    width: fillWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: isCompleted
                              ? [const Color(0xFF22C55E), const Color(0xFF4ADE80)]
                              : [const Color(0xFF2563EB), const Color(0xFF60A5FA)]
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [if (isCompleted) BoxShadow(color: Colors.green.withValues(alpha:0.4), blurRadius: 10)],
                    ),
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOutBack,
                    left: (fillWidth - 20).clamp(0, constraints.maxWidth - 40),
                    top: isProgressHovered ? -35 : -25,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isProgressHovered ? 1.0 : 0.0,
                      child: _PercentageBubble(percentage: percentage, isCompleted: isCompleted),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _PercentageBubble extends StatelessWidget {
  final int percentage;
  final bool isCompleted;
  const _PercentageBubble({required this.percentage, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final bgColor = isCompleted ? const Color(0xFF16A34A) : const Color(0xFF2563EB);
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
          child: Text("$percentage%", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white)),
        ),
        CustomPaint(size: const Size(10, 5), painter: _TrianglePainter(color: bgColor)),
      ],
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;
  _TrianglePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawPath(Path()..moveTo(0, 0)..lineTo(size.width, 0)..lineTo(size.width / 2, size.height)..close(), paint);
  }
  @override
  bool shouldRepaint(CustomPainter old) => false;
}

class _StatusBadge extends StatelessWidget {
  final bool isCompleted;
  const _StatusBadge({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: isCompleted ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(8)),
      child: Text(
        isCompleted ? "COMPLETED" : "IN PROGRESS",
        style: TextStyle(fontSize: 9, fontWeight: FontWeight.w900, color: isCompleted ? const Color(0xFF16A34A) : const Color(0xFFD97706), letterSpacing: 0.5),
      ),
    );
  }
}