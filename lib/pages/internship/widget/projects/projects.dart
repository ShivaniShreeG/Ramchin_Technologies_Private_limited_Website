import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberCardGrid extends StatefulWidget {
  const MemberCardGrid({super.key});

  @override
  State<MemberCardGrid> createState() => _MemberCardGridState();
}

class _MemberCardGridState extends State<MemberCardGrid> with TickerProviderStateMixin {
  final List<MemberCard> members = [
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658151141-548760048.jpeg",
      name: "Shivani Shree G",
      project: "Flutter Developer creating cross-platform apps and scalable, user-friendly solutions.",
      link: "https://shivanishreeg.github.io/HoverSale/",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658155618-43958510.jpg",
      name: "Parthiban R",
      project: "Flutter Developer building cross‑platform apps with backend APIs.",
      link: "https://github.com/parthiban3264/EsateKing",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658164911-985279142.jpeg",
      name: "Balasubramanian M",
      project: "Full‑Stack Developer skilled in Flutter and backend APIs.",
      link: "https://github.com/bala2006-m/Attendance_app",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823819215-698840732.jpeg",
      name: "Rajagopika N",
      project: "Built a modern e-commerce website with seamless shopping.",
      link: "http://tech-gadgets-store.s3-website.eu-north-1.amazonaws.com",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823790530-749043110.jpeg",
      name: "Brightlin A",
      project: "Building smart toy solutions with intuitive web apps for kids and parents.",
      link: "https://ramchintech.com/brightlin/login.php",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823794250-436005492.jpeg",
      name: "Dharsha Gayathri G",
      project: "Designing online footwear experiences with clean layouts and easy navigation.",
      link: "https://ramchintech.com/gaya/login.php",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823827225-185702173.jpeg",
      name: "Sowmiya T",
      project: "Creating hotel booking systems with responsive design and smooth workflows.",
      link: "https://projects.ramchintech.com",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823836715-114713355.jpeg",
      name: "Yogalakshmi K",
      project: "CareKart – E-commerce app tailored for healthcare and personal care products.",
      link: "http://care-kart.s3-website.eu-north-1.amazonaws.com/",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823832626-476931550.jpeg",
      name: "Swarlin Aishwarya B",
      project: "Word Aura – Online book store with attractive layouts and simple checkout.",
      link: "http://word-aura.s3-website.ap-south-1.amazonaws.com/",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823802865-518102426.jpeg",
      name: "Lakshmi K",
      project: "Jewellery e-commerce site highlighting premium collections and easy browsing.",
      link: "http://jewellery-shop1.s3-website.eu-north-1.amazonaws.com/",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823823576-82411444.jpeg",
      name: "Ramu K",
      project: "Online bag shop with modern product cards and mobile-first layouts.",
      link: "http://bag-shop.s3-website.ap-south-1.amazonaws.com/",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823809691-376160524.jpeg",
      name: "Murali K",
      project: "Developer focusing on scalable backend solutions and clean UI.",
      link: "",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823814249-685898487.jpg",
      name: "Pooja M",
      project: "Watch demo of the e‑commerce website implementation.",
      link: "https://ramchintech.com/video/pooja.mp4",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823798685-732528839.jpg",
      name: "Muthu Essakkiammal",
      project: "Watch demo of the e‑commerce website implementation.",
      link: "https://ramchintech.com/video/esakkiammal.mp4",
    ),
  ];
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;
  final Set<int> _animatedIndexes = {};
  late final List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(
      members.length,
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

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _triggerAnimation(int index) {
    if (!_animatedIndexes.contains(index)) {
      _animatedIndexes.add(index);
      Future.delayed(Duration(milliseconds: 70 * (index % 4)), () {
        if (mounted) _controllers[index].forward();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth >= 1100 ? 4 : (constraints.maxWidth >= 800 ? 3 : (constraints.maxWidth >= 600 ? 2 : 1));

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.90, // Adjusted for the new card height
            crossAxisSpacing: 20,
            mainAxisSpacing: 25,
          ),
          itemCount: members.length,
          itemBuilder: (context, index) {
            return VisibilityDetector(
              key: Key('member_$index'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0.2) _triggerAnimation(index);
              },
              child: FadeTransition(
                opacity: _fadeAnimations[index],
                child: SlideTransition(
                  position: _slideAnimations[index],
                  child: InteractiveMemberCard(member: members[index]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class InteractiveMemberCard extends StatefulWidget {
  final MemberCard member;
  const InteractiveMemberCard({super.key, required this.member});

  @override
  State<InteractiveMemberCard> createState() => _InteractiveMemberCardState();
}

class _InteractiveMemberCardState extends State<InteractiveMemberCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
        transform: isHovered
            ? Matrix4.translationValues(0, -10, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: isHovered ? Colors.black.withValues(alpha:0.1) : Colors.black.withValues(alpha:0.05),
              blurRadius: isHovered ? 30 : 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child:Column(
          children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF97316), Color(0xFFEC4899)],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 52,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(widget.member.image),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                widget.member.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 60,
                child: Text(
                  widget.member.project,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            if (widget.member.link.isNotEmpty)
              TextButton(
                onPressed: () => launchUrl(Uri.parse(widget.member.link)),
                child: const Text("View Project"),
              )
            else
                const Text(
                  "Full Stack Developer",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class MemberCard {
  final String image;
  final String name;
  final String project;
  final String link;

  MemberCard({
    required this.image,
    required this.name,
    required this.project,
    required this.link,
  });
}
