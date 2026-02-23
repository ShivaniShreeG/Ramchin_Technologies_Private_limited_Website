import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'team_member.dart';
import 'team_detail_page.dart';

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
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        transform: _hover ? (Matrix4.identity()..translate(0, -10)) : Matrix4.identity(),
        clipBehavior: Clip.hardEdge, // Prevents shadow overflow
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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(), // optional: prevent scrolling
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              // Avatar
                Hero(
                  tag: widget.member.name,
                  child: ClipOval(
                    child: SizedBox(
                      width: 130,
                      height: 130,
                      child: Image.network(
                        widget.member.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.person,
                              size: 50,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

              // Name
              Text(
                widget.member.name,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),

              // Role
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xfff1b9a0).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  widget.member.role,
                  style: const TextStyle(
                    color: Color(0xfff1b9a0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Bio
              Text(
                widget.member.bio,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, height: 1.6),
              ),
              const SizedBox(height: 18),

              // View Profile Button
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TeamDetailPage(member: widget.member),
                    ),
                  );
                },
                child: Text(
                  "View Profile",
                  style: const TextStyle(
                    color: Color(0xfff1b9a0),
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Social Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Color(0xff0077b5),
                      size: 24,
                    ),
                    onPressed: () => _launch(widget.member.linkedinUrl),
                  ),
                  IconButton(
                    icon: const FaIcon(
                      FontAwesomeIcons.github,
                      size: 24,
                    ),
                    onPressed: () => _launch(widget.member.githubUrl),
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.upwork,
                      size: 24,
                      color: Colors.green.shade700,
                    ),
                    onPressed: () => _launch(widget.member.upworkUrl),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
