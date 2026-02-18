import 'package:flutter/material.dart';
import 'widget/team_member.dart';
import 'widget/team_header.dart';
import 'widget/team_card.dart';

class TeamPage extends StatelessWidget {
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
      role: "TEAM LEADER",
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
      role: "SOFTWARE DEVELOPER",
      imageUrl: "assets/member/parthi.jpg",
      bio: "Flutter Developer building cross-platform apps with backend APIs, aiming to grow as a full-stack developer.",
      description: "specializes in Flutter & Node.js...",
      projects: [""],
      experience: [""],
      resumeUrl: "https://resume-priya.com",
      linkedinUrl: "https://www.linkedin.com/in/parthiban-r-822487292/",
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
      bio: "Shivani Shree G – Flutter Developer creating cross-platform apps and full-stack solutions with modern tools for scalable, user-friendly applications.",
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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: const Color(0xfff5f6fa),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TeamHeader(isMobile: isMobile),

            const SizedBox(height: 60),

            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 60),
              child: GridView.builder(
                shrinkWrap: true,
                physics:
                const NeverScrollableScrollPhysics(),
                itemCount: teamMembers.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                  isMobile ? 1 : 3,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 40,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) =>
                    TeamCard(
                        member:
                        teamMembers[index]),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
