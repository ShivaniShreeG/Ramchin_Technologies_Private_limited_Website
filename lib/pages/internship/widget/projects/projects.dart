import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:url_launcher/url_launcher.dart';

/// MODEL
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

class MemberCardGrid extends StatefulWidget {
  const MemberCardGrid({super.key});

  @override
  State<MemberCardGrid> createState() => _MemberCardGridState();
}

class _MemberCardGridState extends State<MemberCardGrid>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<Offset>> _slideAnimations;
  late final List<Animation<double>> _fadeAnimations;
  final Set<int> _animatedIndexes = {};

  final List<MemberCard> members = [
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658151141-548760048.jpeg",
      name: "Shivani Shree G",
      project: "Flutter Developer creating cross-platform apps and scalable, user-friendly solutions.",
      link: "https://shivanishreeg.github.io/HoverSale/",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Interns/1771823819215-698840732.jpeg",
      name: "Rajagopika N",
      project: "Flutter Developer focused on modern e-commerce UI and seamless shopping experiences.",
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
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658155618-43958510.jpg",
      name: "Parthiban R",
      project: "Flutter Developer building cross‑platform apps with backend APIs.",
      link: "",
    ),
    MemberCard(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658164911-985279142.jpeg",
      name: "Balasubramanian M",
      project: "Aspiring Full‑Stack Developer skilled in Flutter and backend APIs.",
      link: "",
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

  void _triggerAnimation(int index) {
    if (!_animatedIndexes.contains(index)) {
      _animatedIndexes.add(index);
      Future.delayed(Duration(milliseconds: 70 * (index % 4)), () {
        if (mounted) _controllers[index].forward();
      });
    }
  }

  Future<void> _openLink(String url) async {
    if (url.trim().isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount;
        if (constraints.maxWidth >= 1100) {
          crossAxisCount = 4;
        } else if (constraints.maxWidth >= 800) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth >= 600) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: isMobile ? 0.85 : 0.96,
            crossAxisSpacing: 14,
            mainAxisSpacing: 12,
          ),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];

            return VisibilityDetector(
              key: Key('member_$index'),
              onVisibilityChanged: (info) {
                if (info.visibleFraction > 0.25) {
                  _triggerAnimation(index);
                }
              },
              child: FadeTransition(
                opacity: _fadeAnimations[index],
                child: SlideTransition(
                  position: _slideAnimations[index],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // circular photo with colored outline like screenshot
                      Container(
                        height: isMobile ? 130 : 140,
                        width: isMobile ? 130 : 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF9FAFB),
                          border: Border.all(
                            color: const Color(0xFFF97316), // orange ring
                            width: 4,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: isMobile ? 56 : 60,
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: Image.network(
                              member.image,
                              width: isMobile ? 112 : 120,
                              height: isMobile ? 112 : 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // name (uppercased, bold, similar to screenshot)
                      Text(
                        member.name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.1,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // description / project (2–3 lines, soft gray)
                      Text(
                        member.project,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: Color(0xFF4B5563),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // bold link, no underline
                      if (member.link.trim().isNotEmpty)
                        InkWell(
                          onTap: () => _openLink(member.link),
                          child: Text(
                            member.link,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1D4ED8),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}