import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// TECH STACK GRID (unchanged)
class TechStackGrid extends StatefulWidget {
  const TechStackGrid({super.key});

  @override
  State<TechStackGrid> createState() => _TechStackGridState();
}

class _TechStackGridState extends State<TechStackGrid>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;
  final Set<int> _animatedIndexes = {};

  final List<Map<String, String>> techStack = [
    {"icon": "assets/react1.png", "name": "React", "desc": "Frontend"},
    {"icon": "assets/flutter.png", "name": "Flutter", "desc": "Mobile"},
    {"icon": "assets/node1.png", "name": "Node.js", "desc": "Backend"},
    {"icon": "assets/mysql21.png", "name": "MySQL", "desc": "Database"},
    {"icon": "assets/mong.png", "name": "MongoDB", "desc": "Database"},
  ];

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      techStack.length,
          (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );

    _slideAnimations = _controllers
        .map(
          (c) => Tween<Offset>(
        begin: const Offset(0, 0.15),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(parent: c, curve: Curves.easeOut),
      ),
    )
        .toList();

    _fadeAnimations = _controllers
        .map(
          (c) => CurvedAnimation(parent: c, curve: Curves.easeIn),
    )
        .toList();
  }

  void _triggerAnimation(int index) {
    if (!_animatedIndexes.contains(index)) {
      _animatedIndexes.add(index);
      Future.delayed(Duration(milliseconds: 100 * (index % 3)), () {
        if (mounted) _controllers[index].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: "Our ",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: "Technology Stack",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [Colors.blue, Colors.purple],
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          "We leverage industry-leading technologies to build robust and scalable solutions",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            if (constraints.maxWidth > 1000) {
              crossAxisCount = 5;
            } else if (constraints.maxWidth > 700) {
              crossAxisCount = 3;
            } else {
              crossAxisCount = 2;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1,
              ),
              itemCount: techStack.length,
              itemBuilder: (context, index) {
                final tech = techStack[index];

                return VisibilityDetector(
                  key: Key("tech_$index"),
                  onVisibilityChanged: (info) {
                    if (info.visibleFraction > 0.2) {
                      _triggerAnimation(index);
                    }
                  },
                  child: FadeTransition(
                    opacity: _fadeAnimations[index],
                    child: SlideTransition(
                      position: _slideAnimations[index],
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha:0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              tech["icon"]!,
                              height: 60,
                              width: 60,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              tech["name"]!,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tech["desc"]!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
