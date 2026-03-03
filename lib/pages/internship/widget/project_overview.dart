import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';
import 'projects/project_page.dart';

// Defined a cohesive Professional Theme
class AppTheme {
  static const Color darkSlate = Color(0xFF0F172A); // Main Text
  static const Color mediumSlate = Color(0xFF334155); // Body Text
  static const Color mutedSlate = Color(0xFF64748B); // Secondary Text
  static const Color primaryBlue = Color(0xFF2563EB); // Accent
  static const Color borderStroke = Color(0xFFE2E8F0); // Subtle borders
  static const Color surfaceBG = Color(0xFFF8FAFC); // Background tint
}

class ProjectPreview extends StatelessWidget {
  const ProjectPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.isMobile(context) ? 24 : 40,
        horizontal: Responsive.isMobile(context) ? 16 : 24,
      ),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          // Header Section
          Column(
            children: [
               Text(
                "Real-World Industry Experience",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: Responsive.isMobile(context)
                      ? 26
                      : Responsive.isTablet(context)
                      ? 34
                      : 44,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.darkSlate,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 12),
              const MaxWidthBox(
                maxWidth: 700,
                child: Text(
                  "Explore the guided projects you will build during our internship program, designed to simulate real-world development workflows under mentor guidance.",                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppTheme.mutedSlate,
                    fontSize: 19,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.isMobile(context) ? 32 : 60),
          // Grid Section
          const MemberCardGrid(),

          SizedBox(height: Responsive.isMobile(context) ? 32 : 60),

          ElevatedButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProjectPage())),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.darkSlate,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("EXPLORE ALL PROJECTS", style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                SizedBox(width: 12),
                Icon(Icons.arrow_right_alt_rounded, size: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
          MediaQuery.of(context).size.width < 1024;
}

class MemberCardGrid extends StatefulWidget {
  const MemberCardGrid({super.key});

  @override
  State<MemberCardGrid> createState() => _MemberCardGridState();
}

class _MemberCardGridState extends State<MemberCardGrid> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  final Set<int> _animatedIndexes = {};

  final List<MemberCardData> members = [
    MemberCardData(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658151141-548760048.jpeg",
      name: "Shivani Shree G",
      project: "Flutter Developer creating cross-platform apps and scalable, user-friendly solutions.",
      link: "https://shivanishreeg.github.io/HoverSale/",
    ),
    MemberCardData(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658155618-43958510.jpg",
      name: "Parthiban R",
      project: "Flutter Developer building cross‑platform apps with backend APIs.",
      link: "https://github.com/parthiban3264/EsateKing",
    ),
    MemberCardData(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658164911-985279142.jpeg",
      name: "Balasubramanian M",
      project: "Full‑Stack Developer skilled in Flutter and backend APIs.",
      link: "https://github.com/bala2006-m/school_attendance",
    ),
    MemberCardData(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823819215-698840732.jpeg",
      name: "Rajagopika N",
      project: "Full-Stack Developer focused on modern e-commerce UI and seamless shopping experiences.",
      link: "http://tech-gadgets-store.s3-website.eu-north-1.amazonaws.com",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      members.length,
          (i) => AnimationController(vsync: this, duration: const Duration(milliseconds: 600)),
    );
  }

  void _triggerAnimation(int index) {
    if (!_animatedIndexes.contains(index)) {
      _animatedIndexes.add(index);
      Future.delayed(Duration(milliseconds: index * 100), () {
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
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth >= 1100 ? 4 : constraints.maxWidth >= 700 ? 2 : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisExtent: Responsive.isMobile(context)
                ? 240   // mobile fixed height
                : Responsive.isTablet(context)
                ? 280
                : 320,
            crossAxisSpacing: Responsive.isMobile(context) ? 16 : 24,
            mainAxisSpacing: Responsive.isMobile(context) ? 16 : 24,
          ),
          itemCount: members.length,
          itemBuilder: (context, index) {
            return VisibilityDetector(
              key: Key('member_anim_$index'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0.1) _triggerAnimation(index);
              },
              child: FadeTransition(
                opacity: _controllers[index],
                child: SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
                    CurvedAnimation(parent: _controllers[index], curve: Curves.easeOut),
                  ),
                  child: ProfessionalMemberCard(member: members[index]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class ProfessionalMemberCard extends StatefulWidget {
  final MemberCardData member;
  const ProfessionalMemberCard({super.key, required this.member});

  @override
  State<ProfessionalMemberCard> createState() => _ProfessionalMemberCardState();
}

class _ProfessionalMemberCardState extends State<ProfessionalMemberCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),

      // 🔻 REDUCED CARD PADDING
      padding: EdgeInsets.all(
        isMobile ? 14 : isTablet ? 20 : 26,
      ),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isHovered ? AppTheme.primaryBlue : AppTheme.borderStroke,
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          // 🔻 SMALLER AVATAR
          CircleAvatar(
            radius: isMobile ? 26 : isTablet ? 34 : 40,
            backgroundImage: NetworkImage(widget.member.image),
          ),

          SizedBox(height: isMobile ? 12 : isTablet ? 16 : 24),

          Text(
            widget.member.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 15 : isTablet ? 16 : 18,
              fontWeight: FontWeight.w700,
              color: AppTheme.darkSlate,
            ),
          ),

          SizedBox(height: isMobile ? 6 : 12),

          Text(
            widget.member.project,
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: isMobile ? 12.5 : 14,
              height: 1.4,
              color: AppTheme.mediumSlate,
            ),
          ),

          SizedBox(height: isMobile ? 8 : 14),

          if (widget.member.link.isNotEmpty)
            TextButton(
              onPressed: () => launchUrl(Uri.parse(widget.member.link)),
              child: const Text("View Project"),
            ),
        ],
      ),
    );
  }
}

class MaxWidthBox extends StatelessWidget {
  final double maxWidth;
  final Widget child;
  const MaxWidthBox({super.key, required this.maxWidth, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: child,
    );
  }
}

class MemberCardData {
  final String image, name, project, link;
  MemberCardData({
    required this.image,
    required this.name,
    required this.project,
    required this.link,
  });
}