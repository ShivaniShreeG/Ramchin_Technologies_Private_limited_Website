import 'package:flutter/material.dart';
import 'course/flutter.dart';
import 'course/react.dart';
import 'course/react_native.dart';
import 'course/angular.dart';

class CourseData {
  final String title, subtitle;
  final String imagePath;
  final Color color;
  CourseData(this.title, this.subtitle, this.imagePath, this.color);
}

final List<CourseData> courses = [
  CourseData("Flutter", "Build cross-platform apps", "https://www.ramchintech.com/companyweb/Icon/1772637232672-883463208.png", const Color(0xFF02539A)),
  CourseData("React", "Modern web development", "https://www.ramchintech.com/companyweb/Icon/1772637262645-426500600.png", const Color(0xFF61DAFB)),
  CourseData("React Native", "Mobile apps with JS", "https://www.ramchintech.com/companyweb/Icon/1772637262645-426500600.png", const Color(0xFF00BCD4)),
  CourseData("Angular", "Enterprise web apps", "https://www.ramchintech.com/companyweb/Icon/1772637225631-33144048.png", const Color(0xFFDD0031)),
];

class Courses extends StatelessWidget {

  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 1024 ? 4 : (constraints.maxWidth > 700 ? 2 : 1);

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha:0.08),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "INTERNSHIP PROGRAMS",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Level Up Your Skills\nWith Industry-Focused Learning",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      color: Color(0xFF0F172A),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const SizedBox(
                    width: 720,
                    child: Opacity(
                      opacity: 0.75,
                      child: Text(
                        "Gain real-world experience by working on industry-level projects while mastering in-demand technologies.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          height: 1.6,
                          color: Color(0xFF334155),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 64),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: courses.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 24,
                    mainAxisSpacing: 24,
                    childAspectRatio:0.99,
                  ),
                  itemBuilder: (context, index) => _EnhancedCourseCard(
                    course: courses[index],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
class _EnhancedCourseCard extends StatefulWidget {
  final CourseData course;

  const _EnhancedCourseCard({required this.course});

  @override
  State<_EnhancedCourseCard> createState() => _EnhancedCourseCardState();
}

class _EnhancedCourseCardState extends State<_EnhancedCourseCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: GestureDetector(
          onTap: _navigateToCourse,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: _isHovered
                    ? widget.course.color.withValues(alpha:0.3)
                    : Colors.grey.withValues(alpha:0.1),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: _isHovered
                      ? widget.course.color.withValues(alpha:0.15)
                      : Colors.black.withValues(alpha:0.05),
                  blurRadius: 40,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 64,
                        width: 64,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: widget.course.color.withValues(alpha:0.08),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Image.network(
                          widget.course.imagePath,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image, color: widget.course.color),
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        widget.course.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1E293B),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        widget.course.subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueGrey.shade600,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child:TextButton(
                          onPressed: _navigateToCourse,
                          style: TextButton.styleFrom(
                            foregroundColor: widget.course.color,
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text("Explore Program"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _navigateToCourse() {
    Widget page;

    switch (widget.course.title) {
      case "Flutter":
        page = const FlutterPage();
        break;
      case "React":
        page = const ReactPage();
        break;
      case "React Native":
        page = const ReactNativePage();
        break;
      case "Angular":
        page = const AngularPage();
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }
}