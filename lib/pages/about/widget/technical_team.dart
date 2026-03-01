import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TeamMember {
  final String image;
  final String name;
  final String role;
  final String bio;
  final String linkedin;
  final String github;
  final String upwork;
  final String resumeUrl; // Added field

  TeamMember({
    required this.image,
    required this.name,
    required this.role,
    required this.bio,
    required this.linkedin,
    required this.github,
    required this.upwork,
    required this.resumeUrl, // Added required parameter
  });
}

class TeamSection extends StatelessWidget {
  TeamSection({super.key});

  final List<TeamMember> teamMembers = [
    TeamMember(
      image: "https://www.ramchintech.com/companyweb/Profile/Management_Member/1771656786530-747879659.jpg",
      name: "Dr. C Velayutham",
      role: "Architect",
      bio: "Creative architect specializing in sustainable and futuristic designs.",
      linkedin: "https://www.linkedin.com/in/velayutham-c-8a18a9166/",
      github: "https://github.com/cvelayutham",
      upwork: "https://upwork.com",
      resumeUrl: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/Resume/1771827196315-154788124.pdf",
    ),
    TeamMember(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658164911-985279142.jpeg",
      name: "Balasubramanian M",
      role: "Team Leader",
      bio: "Flutter developer building scalable cross-platform applications.",
      linkedin: "https://www.linkedin.com/in/balasubramanian-m-84a8b8292/",
      github: "https://github.com/bala2006-m",
      upwork: "https://upwork.com",
      resumeUrl: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/Resume/1771827215865-444573150.jpeg",
    ),
    TeamMember(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658155618-43958510.jpg",
      name: "Parthiban R",
      role: "Software Developer",
      bio: "Flutter developer focused on clean UI and backend integration.",
      linkedin: "https://www.linkedin.com/in/parthiban-r-822487292/",
      github: "https://github.com/parthiban3264",
      upwork: "https://upwork.com",
      resumeUrl: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/Resume/1771827215865-444573150.jpeg",
    ),
    TeamMember(
      image: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/1771658151141-548760048.jpeg",
      name: "SHIVANI SHREE G",
      role: "Software Developer",
      bio: "Creating cross-platform apps and full-stack solutions with modern tools.",
      linkedin: "https://www.linkedin.com/in/shivani-shree-g/",
      github: "https://github.com/ShivaniShreeG",
      upwork: "https://upwork.com/freelancers/~01jkl012mno345",
      resumeUrl: "https://www.ramchintech.com/companyweb/Profile/Software_Developer/Resume/1771827215865-444573150.jpeg",
    ),
  ];

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      color: const Color(0xFFF8FAFC),
      child: Column(
        children: [
          const Text(
            "OUR EXPERTS",
            style: TextStyle(
              fontSize: 14,
              letterSpacing: 2,
              fontWeight: FontWeight.w800,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Technical Engineering Team",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 25,
            runSpacing: 25,
            alignment: WrapAlignment.center,
            children: teamMembers.map((member) => _buildTechCard(member)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTechCard(TeamMember member) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF64748B).withValues(alpha:0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blueAccent.withValues(alpha:0.2), width: 2),
                ),
              ),
              CircleAvatar(
                radius: 44,
                backgroundColor: Colors.grey.shade100,
                backgroundImage: NetworkImage(member.image),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            member.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            member.role.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              letterSpacing: 1,
              fontWeight: FontWeight.w600,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            member.bio,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              color: Colors.blueGrey.shade600,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),

          InkWell(
            onTap: () => _launch(member.resumeUrl),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "View Resume",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1E293B).withValues(alpha:0.8),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.keyboard_arrow_right_rounded,
                    size: 18,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialIcon(FontAwesomeIcons.linkedinIn, const Color(0xFF0A66C2), member.linkedin),
              _socialIcon(FontAwesomeIcons.github, const Color(0xFF181717), member.github),
              _socialIcon(FontAwesomeIcons.upwork, const Color(0xFF14A800), member.upwork),
            ],
          ),


        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, Color color, String url) {
    return _InteractiveSocialBtn(icon: icon, color: color, url: url);
  }

}
class _InteractiveSocialBtn extends StatefulWidget {
  final IconData icon;
  final Color color;
  final String url;

  const _InteractiveSocialBtn({required this.icon, required this.color, required this.url});

  @override
  State<_InteractiveSocialBtn> createState() => _InteractiveSocialBtnState();
}

class _InteractiveSocialBtnState extends State<_InteractiveSocialBtn> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(widget.url)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            // When hovered, use full color. When not, use a subtle ghost version.
            color: isHovered ? widget.color : widget.color.withValues(alpha:0.08),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              if (isHovered)
                BoxShadow(
                  color: widget.color.withValues(alpha:0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
            ],
          ),
          child: FaIcon(
            widget.icon,
            // Flip the icon color to white when the background fills up
            color: isHovered ? Colors.white : widget.color,
            size: 18,
          ),
        ),
      ),
    );
  }
}