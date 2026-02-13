import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamPage extends StatefulWidget {
  TeamPage({super.key});

  final List<TeamMember> teamMembers = [
    TeamMember(
      name: "DR.C.VELAYUTHAM",
      role: "ARCHITECT",
      imageUrl: "assets/cvsir2.jpg",
      bio:
      "Creative and detail-oriented Architect specializing in innovative, sustainable, and functional design.",
      description:
      "Dr. Velayutham has led multiple architectural projects focused on sustainable development and futuristic design systems.",
      projects: ["Urban Housing", "Smart Villa", "Eco Tower"],
      experience: ["15+ Years", "International Projects", "Award Winner"],
      resumeUrl: "https://resume-link.com",
      linkedinUrl:
      "https://www.linkedin.com/in/velayutham-c-8a18a9166/",
      githubUrl: "https://github.com/cvelayutham",
      upworkUrl: "https://upwork.com/freelancers/~01abc123def456",
      reviews: [
        "Outstanding vision and execution.",
        "Transformed our project beyond expectations."
      ],
    ),
    TeamMember(
      name: "BALASUBRAMANIAN M",
      role: "\n TEAM LEADER",
      imageUrl: "assets/member/bala.jpg",
      bio:
      "Aspiring Full-Stack Developer skilled in Flutter, building cross-platform apps with powerful backend APIs.",
      description: "specializes in Flutter & Node.js...",
      projects: [""],
      experience: [""],
      resumeUrl: "https://resume-priya.com",
      linkedinUrl: "https://www.linkedin.com/in/balasubramanian-m-84a8b8292/",
      githubUrl: "https://github.com/bala2006-m",
      upworkUrl: "https://upwork.com/freelancers/~01def456ghi789",
      reviews: [
        "Amazing coding skills! – Client X",
        "Delivers projects on time. – Client Y",
      ],
    ),
    TeamMember(
      name: "PARTHIBAN R",
      role: "\n SOFTWARE DEVELOPER",
      imageUrl: "assets/member/parthi_11zon.jpg",
      bio:
      "Flutter Developer building cross-platform apps with backend APIs, aiming to grow as a full-stack developer.",
      description: "specializes in Flutter & Node.js...",
      projects: [""],
      experience: [""],
      resumeUrl: "https://resume-priya.com",
      linkedinUrl: "https://linkedin.com/in/parthiban-r",
      githubUrl: "https://github.com/parthiban3264",
      upworkUrl: "https://www.upwork.com/freelancers/~015a100a32dfed77ba/",
      reviews: [
        "Amazing coding skills! – Client X",
        "Delivers projects on time. – Client Y",
      ],
    ),
    TeamMember(
      name: "SHIVANI SHREE G",
      role: "SOFTWARE DEVELOPER",
      imageUrl: "assets/member/shivani.jpeg",
      bio:
      "Shivani Shree G – Flutter Developer creating cross-platform apps and full-stack solutions with modern tools for scalable, user-friendly applications.",
      description: "specializes in Flutter & Node.js...",
      projects: [""],
      experience: [""],
      resumeUrl: "https://resume-priya.com",
      linkedinUrl: "https://www.linkedin.com/in/shivani-shree-g/",
      githubUrl: "https://github.com/ShivaniShreeG",
      upworkUrl: "https://upwork.com/freelancers/~01jkl012mno345",
      reviews: [
        "Amazing coding skills! – Client X",
        "Delivers projects on time. – Client Y",
      ],
    ),
  ];

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      body: SingleChildScrollView(
        child: Column(
          children: [

            /// 🔥 MODERN HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 80),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xfff1b9a0),
                    Color(0xfff9d5c4),
                    Colors.white
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  const Text(
                    "Our Team",
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 600,
                    child: Text(
                      "Meet the creative professionals building scalable and modern digital experiences.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        height: 1.6,
                        color: Colors.black87.withOpacity(0.7),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 60),

            /// 🔥 GRID
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.teamMembers.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile ? 1 : 3,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 40,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) =>
                    TeamCard(member: widget.teamMembers[index]),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class TeamCard extends StatefulWidget {
  final TeamMember member;
  const TeamCard({super.key, required this.member});

  @override
  State<TeamCard> createState() => _TeamCardState();
}

class _TeamCardState extends State<TeamCard> {
  bool _hover = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform:
        _hover ? (Matrix4.identity()..translate(0, -10)) : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: _hover
                  ? const Color(0xfff1b9a0).withOpacity(0.4)
                  : Colors.black.withOpacity(0.08),
              blurRadius: _hover ? 35 : 15,
              offset: const Offset(0, 15),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Column(
            children: [

              /// HERO IMAGE
              Hero(
                tag: widget.member.name,
                child: CircleAvatar(
                  radius: 65,
                  backgroundImage:
                  AssetImage(widget.member.imageUrl),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                widget.member.name,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              /// ROLE BADGE
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xfff1b9a0).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  widget.member.role,
                  style: const TextStyle(
                      color: Color(0xfff1b9a0),
                      fontWeight: FontWeight.w600),
                ),
              ),

              const SizedBox(height: 18),

              Text(
                widget.member.bio,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14, height: 1.6, color: Colors.black87),
              ),

              const SizedBox(height: 22),

              /// VIEW PROFILE
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>
                            TeamDetailPage(member: widget.member)),
                  );
                },
                child: const Text(
                  "View Profile",
                  style: TextStyle(
                    color: Color(0xfff1b9a0),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// SOCIAL
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      icon: const FaIcon(FontAwesomeIcons.linkedin,
                          color: Color(0xff0077b5)),
                      onPressed: () =>
                          _launch(widget.member.linkedinUrl)),
                  IconButton(
                      icon: const FaIcon(FontAwesomeIcons.github),
                      onPressed: () =>
                          _launch(widget.member.githubUrl)),
                  IconButton(
                      icon: const FaIcon(FontAwesomeIcons.upwork),
                      onPressed: () =>
                          _launch(widget.member.upworkUrl)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TeamDetailPage extends StatelessWidget {
  final TeamMember member;
  const TeamDetailPage({super.key, required this.member});

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 280,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xfff1b9a0), Color(0xfff9d5c4)],
                ),
              ),
              child: Center(
                child: Hero(
                  tag: member.name,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundImage: AssetImage(member.imageUrl),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            Text(member.name,
                style:
                const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),

            const SizedBox(height: 10),

            Text(member.role,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xfff1b9a0))),

            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text("About",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(member.description,
                      style: const TextStyle(height: 1.6)),

                  const SizedBox(height: 30),

                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _launch(member.resumeUrl),
                      icon: const Icon(Icons.picture_as_pdf),
                      label: const Text("View Resume"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xfff1b9a0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 14)),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class TeamMember {
  final String name;
  final String role;
  final String imageUrl;
  final String bio;
  final String description;
  final List<String> projects;
  final List<String> experience;
  final String resumeUrl;
  final String linkedinUrl;
  final String githubUrl;
  final String upworkUrl;
  final List<String> reviews;

  TeamMember({
    required this.name,
    required this.role,
    required this.imageUrl,
    required this.bio,
    required this.description,
    required this.projects,
    required this.experience,
    required this.resumeUrl,
    required this.linkedinUrl,
    required this.githubUrl,
    required this.upworkUrl,
    required this.reviews,
  });
}