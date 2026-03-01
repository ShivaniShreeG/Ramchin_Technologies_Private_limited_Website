import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:simple_icons/simple_icons.dart';

class OurTechStackCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final List<Color> colors;
  final int index; // for stagger animation

  const OurTechStackCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.colors,
    required this.index,
  });

  @override
  State<OurTechStackCard> createState() => _OurTechStackCardState();
}

class _OurTechStackCardState extends State<OurTechStackCard> {
  bool _isHovered = false;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // staggered animation for fade-in
    Future.delayed(Duration(milliseconds: widget.index * 200), () {
      if (mounted) setState(() => _isVisible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;
    final bool active = !isMobile && _isHovered;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: _isVisible ? 1 : 0,
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: _isVisible ? Offset.zero : const Offset(0, 0.2),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) {
            if (!isMobile) setState(() => _isHovered = true);
          },
          onExit: (_) {
            if (!isMobile) setState(() => _isHovered = false);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            // no zoom / rotation on hover
            transform: Matrix4.identity(),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.colors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: widget.colors.last.withValues(alpha:0.25),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.all(10),
            child: isMobile
            // Mobile → icon + title
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, size: 30, color: Colors.white),
                const SizedBox(height: 10),
                Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            )
            // Desktop → hover shows description only
                : AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              transitionBuilder: (child, animation) =>
                  FadeTransition(opacity: animation, child: child),
              child: active
                  ? Text(
                widget.description,
                key: const ValueKey("description"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: Colors.white,
                ),
              )
                  : Column(
                key: const ValueKey("iconAndTitle"),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon, size: 30, color: Colors.white),
                  const SizedBox(height: 10),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OurTechStackSection extends StatelessWidget {
  const OurTechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    final techStack = [
      OurTechStackCard(
        index: 0,
        icon: FontAwesomeIcons.mobileScreenButton,
        title: "Flutter",
        description:
        "Crafting visually appealing, cross-platform mobile apps that deliver a native-like experience.",
        colors: [const Color(0xFF60C5FF), Colors.blueAccent],
      ),
      OurTechStackCard(
        index: 1,
        icon: FontAwesomeIcons.react,
        title: "React Native",
        description:
        "Build native mobile apps with JavaScript & React and user-friendly interfaces with reusable components.",
        colors: [Colors.cyan, Colors.blue],
      ),
      OurTechStackCard(
        index: 2,
        icon: FontAwesomeIcons.react,
        title: "React",
        description:
        "Creating dynamic, fast, and user-friendly interfaces with reusable components.",
        colors: [Colors.blueAccent, Colors.blueAccent],
      ),
      OurTechStackCard(
        index: 3,
        icon: FontAwesomeIcons.angular,
        title: "Angular",
        description: "Enterprise-grade frontend web applications.",
        colors: [const Color(0xFFE60808), const Color(0xFFE60808)],
      ),
      OurTechStackCard(
        index: 4,
        icon: FontAwesomeIcons.nodeJs,
        title: "Node.js",
        description:
        "Developing scalable and efficient server-side applications with real-time capabilities.",
        colors: [Colors.green, Colors.teal],
      ),
      OurTechStackCard(
        index: 5,
        icon: SimpleIcons.nestjs,
        title: "Nest.js",
        description:
        "Building highly optimized, server-rendered, and SEO-friendly applications.",
        colors: [const Color(0xFFE0234E), const Color(0xFFE0234E)],
      ),
      OurTechStackCard(
        index: 6,
        icon: FontAwesomeIcons.server,
        title: "Express.js",
        description:
        "We express seamless communication between the frontend and backend layers while maintaining superior performance and security.",
        colors: [Colors.yellow, Colors.orange],
      ),
      OurTechStackCard(
        index: 7,
        icon: FontAwesomeIcons.microsoft,
        title: ".NET",
        description:
        "Building enterprise-grade, secure, and performance-driven applications tailored for diverse industries.",
        colors: [Colors.purple, Colors.purpleAccent],
      ),
      OurTechStackCard(
        index: 8,
        icon: FontAwesomeIcons.php,
        title: "PHP",
        description:
        "We craft tailored solutions that are secure, scalable, and maintainable.",
        colors: [Colors.deepPurple, Colors.indigo],
      ),
      OurTechStackCard(
        index: 9,
        icon: FontAwesomeIcons.database,
        title: "MySQL",
        description:
        "Designing structured and scalable relational database systems for your business needs.",
        colors: [Colors.deepOrange, Colors.orangeAccent],
      ),
      OurTechStackCard(
        index: 10,
        icon: FontAwesomeIcons.database,
        title: "MongoDB",
        description:
        "Delivering flexibility and speed with NoSQL database solutions, perfect for handling large datasets.",
        colors: [Colors.green, Colors.lightGreen],
      ),
      OurTechStackCard(
        index: 11,
        icon: FontAwesomeIcons.python,
        title: "Python",
        description:
        "Powerful and versatile language for AI, data science, backend, and automation.",
        colors: [Colors.blueAccent.shade700, Colors.yellow.shade500],
      ),
    ];

    int crossAxisCount;
    double childAspectRatio;

    if (width >= 1000) {
      // Desktop: 6 columns → 2 rows for 12 items
      crossAxisCount = 6;
      childAspectRatio = 1.2; // wider, less tall
    } else if (width >= 600) {
      // Tablet
      crossAxisCount = 3;
      childAspectRatio = 1;
    } else {
      // Mobile
      crossAxisCount = 2;
      childAspectRatio = 0.9;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: techStack.length,
      itemBuilder: (context, index) => techStack[index],
    );
  }
}

class OurTechStack extends StatelessWidget {
  final String title;
  final String description;
  final String? subtitle;
  final TextAlign textAlign;

  const OurTechStack({
    super.key,
    required this.title,
    required this.description,
    this.subtitle,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    var isMobile = MediaQuery.sizeOf(context).width < 600;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: const Color(0xFFF7F9FC),
      child: Column(
        crossAxisAlignment: textAlign == TextAlign.center
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: isMobile ? 25 : 34,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            description,
            textAlign: textAlign,
            style: TextStyle(
              fontSize: isMobile ? 15 : 18,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 25),
            Text(
              subtitle!,
              textAlign: textAlign,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
          const SizedBox(height: 40),
          const OurTechStackSection(),
        ],
      ),
    );
  }
}