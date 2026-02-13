import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../pages/AddPage/ViewContact.dart';
import '../pages/Home/AdminHomePage.dart';
import '../pages/Home/GalleryHomePage.dart';
import '../pages/Home/InternshipHomePage.dart';
import '../pages/Home/admindash.dart';
import '../pages/Home/createcourse.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData>
    with SingleTickerProviderStateMixin {
  int hoveredIndex = -1;

  late AnimationController _controller;
  late Animation<double> _expandAnim;

  final List<Map<String, dynamic>> items = [
    {
      "icon": Icons.photo_library,
      "page": const GalleryHomePage(),
      "title": "Gallery Manager",
      "color": const Color(0xFF1ABC9C),
    },
    {
      "icon": Icons.admin_panel_settings,
      "page": const AdminHomePage(),
      "title": "Add Admin",
      "color": const Color(0xFF3498DB),
    },
    {
      "icon": Icons.school,
      "page": const InternshipHomePage(),
      "title": "Add Internship",
      "color": const Color(0xFF9B59B6),
    },
    {
      "icon": Icons.message,
      "page": const ContactTable(),
      "title": "View Messages",
      "color": const Color(0xFFE67E22),
    },
    {
      "icon": Icons.dashboard,
      "page": const AdminDashboard(),
      "title": "Dashboard",
      "color": const Color(0xFFE74C3C),
    },
    {
      "icon": Icons.add,
      "page": const CreateCoursePage(),
      "title": "Add Course",
      "color": const Color(0xFF2ECC71),
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400), // slow expand
    );
    _expandAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final radius = math.min(size.width, size.height) * 0.38;
    final center = Offset(size.width / 2, size.height / 2);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// ===== CINEMATIC DARK OVERLAY =====
          // Container(
          //   decoration: BoxDecoration(
          //     gradient: RadialGradient(
          //       radius: 1.3,
          //       colors: [
          //         Colors.black.withOpacity(0.25),
          //         Colors.black.withOpacity(0.85),
          //       ],
          //     ),
          //   ),
          // ),

          /// ===== RADIAL MENU =====
          Center(
            child: SizedBox(
              width: radius * 2,
              height: radius * 2,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) {
                  final dx = details.localPosition.dx - radius;
                  final dy = details.localPosition.dy - radius;
                  final distance = math.sqrt(dx * dx + dy * dy);

                  if (distance <= radius && distance >= radius * 0.45) {
                    final angle =
                        (math.atan2(dy, dx) + math.pi / 2 + 2 * math.pi) %
                            (2 * math.pi);

                    final index =
                    (angle / (2 * math.pi / items.length)).floor();

                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        transitionDuration:
                        const Duration(milliseconds: 200),
                        pageBuilder: (_, __, ___) =>
                        items[index]["page"] as Widget,
                        transitionsBuilder: (_, anim, __, child) =>
                            FadeTransition(opacity: anim, child: child),
                      ),
                    );
                  }
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.precise,
                  onHover: (event) {
                    final dx = event.localPosition.dx - radius;
                    final dy = event.localPosition.dy - radius;
                    final distance = math.sqrt(dx * dx + dy * dy);

                    if (distance <= radius && distance >= radius * 0.45) {
                      final angle =
                          (math.atan2(dy, dx) +
                              math.pi / 2 +
                              2 * math.pi) %
                              (2 * math.pi);

                      final index =
                      (angle / (2 * math.pi / items.length)).floor();

                      if (hoveredIndex != index) {
                        setState(() => hoveredIndex = index);
                        _controller.forward(from: 0);
                      }
                    } else {
                      setState(() => hoveredIndex = -1);
                    }
                  },
                  onExit: (_) => setState(() => hoveredIndex = -1),
                  child: AnimatedBuilder(
                    animation: _expandAnim,
                    builder: (_, __) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          /// ===== OUTER RING =====
                          Container(
                            width: radius * 2,
                            height: radius * 2,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xFF0B1117),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 30,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                          ),

                          /// ===== PIE SLICES =====
                          CustomPaint(
                            size: Size(radius * 2, radius * 2),
                            painter: InteractivePiePainter(
                              hoveredIndex: hoveredIndex,
                              itemCount: items.length,
                              expandValue: _expandAnim.value,
                              colors: List.generate(items.length, (i) {
                                return hoveredIndex == i
                                    ? const Color(0xFF4FC3F7) // Active blue
                                    : const Color(0xFF0C1A7C); // Dark blue grey
                              }),
                            ),
                          ),

                          /// ===== ICONS =====
                          ...List.generate(items.length, (i) {
                            final sweep = 2 * math.pi / items.length;
                            final midAngle =
                                -math.pi / 2 + i * sweep + sweep / 2;

                            final isHovered = hoveredIndex == i;
                            final iconRadius =
                            isHovered ? radius * 0.80 : radius * 0.72;

                            return Transform.translate(
                              offset: Offset(
                                iconRadius * math.cos(midAngle),
                                iconRadius * math.sin(midAngle),
                              ),
                              child: AnimatedScale(
                                scale: isHovered ? 1.2 : 1,
                                duration:
                                const Duration(milliseconds: 120),
                                child: Icon(
                                  items[i]["icon"] as IconData,
                                  color: isHovered
                                      ? Colors.black
                                      : Colors.white70,
                                  size: 34,
                                ),
                              ),
                            );
                          }),

                          /// ===== CENTER HUB =====
                      Container(
                      width: radius * 0.95,
                      height: radius * 0.95,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      shape: BoxShape.circle,

                      border: Border.all(
                      color: Colors.white,
                      width: hoveredIndex != -1 ? 3 : 2,
                      ),
                      boxShadow: [
                      BoxShadow(
                      color: const Color(0xFF4FC3F7).withOpacity(0.45),
                      blurRadius: hoveredIndex != -1 ? 30 : 18,
                      spreadRadius: hoveredIndex != -1 ? 6 : 2,
                      ),
                      const BoxShadow(
                      color: Colors.black54,
                      blurRadius: 25,
                      spreadRadius: 10,
                      ),
                      ],
                      ),
                      child: Center(
                      child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 280),
                      child: hoveredIndex != -1
                      ? Text(
                      items[hoveredIndex]["title"],
                      key: ValueKey(items[hoveredIndex]["title"]),
                      style: const TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      letterSpacing: 2.2,
                      fontWeight: FontWeight.bold,
                      ),
                      )
                          : Image.asset(
                      'ic_launcher.png',
                      width: radius * 0.45,
                      height: radius * 0.45,
                      fit: BoxFit.cover,
                      ),
                      ),
                      ),
                      ),
                      ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================================
///                 PIE PAINTER
/// =======================================================
class InteractivePiePainter extends CustomPainter {
  final int hoveredIndex;
  final int itemCount;
  final double expandValue;
  final List<Color> colors;

  InteractivePiePainter({
    required this.hoveredIndex,
    required this.itemCount,
    required this.expandValue,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final baseRadius = size.width / 2;
    final sweep = 2 * math.pi / itemCount;

    for (int i = 0; i < itemCount; i++) {
      final bool isHovered = hoveredIndex == i;
      final double startAngle = -math.pi / 2 + i * sweep;

      final double radius = isHovered
          ? lerpDouble(baseRadius, baseRadius * 1.12, expandValue)!
          : baseRadius;

      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweep,
        true,
        paint,
      );

      /// Divider
      final dividerPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 2;

      final x = center.dx + radius * math.cos(startAngle);
      final y = center.dy + radius * math.sin(startAngle);
      canvas.drawLine(center, Offset(x, y), dividerPaint);
    }
  }

  @override
  bool shouldRepaint(covariant InteractivePiePainter oldDelegate) {
    return oldDelegate.hoveredIndex != hoveredIndex ||
        oldDelegate.expandValue != expandValue;
  }
}
