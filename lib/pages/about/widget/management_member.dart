import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ManagementMember {
  final String image;
  final String name;
  final String role;
  final String description;
  final String pdfPath;

  ManagementMember({
    required this.image,
    required this.name,
    required this.role,
    required this.description,
    required this.pdfPath,
  });
}

class MemberSection extends StatelessWidget {
  MemberSection({super.key});

  final List<ManagementMember> members = [
    ManagementMember(
      image: "https://www.ramchintech.com/companyweb/Profile/Management_Member/1771656786530-747879659.jpg",
      name: "Dr. C VELAYUTHAM",
      role: "Managing Director",
      description: "Dr C Velayutham, is the Managing Director of Ramchin Technologies (P) Ltd. He did Postgraduate in Applied Mathematics, Doctoral degree in Computer Science.",
      pdfPath: "https://www.ramchintech.com/companyweb/Profile/Management_Member/Resume/1771827196315-154788124.pdf",
    ),
    ManagementMember(
      image: "https://www.ramchintech.com/companyweb/Profile/Management_Member/1771656780491-304047309.png",
      name: "Mrs V THIRAVIDAMOZHI, MBA",
      role: "Director HRD",
      description: "Mrs. V Thiravidamozhi is the Director of Ramchin Technologies (P) Ltd. She did MBA (HRD) in Alagappa University, Karaikudi.",
      pdfPath: "https://www.ramchintech.com/companyweb/Profile/Management_Member/Resume/1771827208715-231557912.pdf",
    ),
    ManagementMember(
      image: "https://www.ramchintech.com/companyweb/Profile/Management_Member/1772102788086-625076359.jpeg",
      name: "SENTHIL RAMCHIN V",
      role: "Data Analyst",
      description: "Mr Senthil Ramchin V is the Data Analyst of Ramchin Technologies (P) Ltd. He is M.Sc Post Graduate in Mathematics.",
      pdfPath: "https://www.ramchintech.com/companyweb/Profile/Management_Member/Resume/1771827215865-444573150.jpeg",
    ),
    ManagementMember(
      image: "https://www.ramchintech.com/companyweb/Profile/Management_Member/1771656772117-811992019.png",
      name: "SARAVANA RAMCHIN V",
      role: "Director - Operations",
      description: "Mr Saravana Ramchin V is the Director Admin of Ramchin Technologies (P) Ltd. He is B.E Graduate in Computer Science and Engineering.",
      pdfPath: "https://www.ramchintech.com/companyweb/Profile/Management_Member/Resume/1771827215865-444573150.jpeg",
    ),
  ];

  Future<void> _openPdf(String path) async {
    final Uri url = Uri.parse(path);
    try {
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        debugPrint("Could not launch $path");
      }
    } catch (e) {
      debugPrint("Error launching URL: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
      ),
      child: Column(
        children: [
          // --- Header Section ---
          Text(
            "OUR LEADERSHIP",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 2.0,
              color: Colors.blueAccent.shade700,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Management Team",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w900,
              color: Color(0xFF0F172A), // Deep Navy
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 32),

          Wrap(
            spacing: 20,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: members.map((member) => _buildMemberCard(member)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(ManagementMember member) {
    return SizedBox(
      width: 290,
      child: InkWell(
        onTap: () => _openPdf(member.pdfPath),
        borderRadius: BorderRadius.circular(24),
        hoverColor: Colors.blueAccent.withOpacity(0.04),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withOpacity(0.06),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Column(
            children: [
              // --- Image Header ---
              Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blueAccent.shade100.withOpacity(0.1),
                          Colors.white
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                    ),
                  ),
                  Positioned(
                    top: 30,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                      ),
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(member.image),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),

              // --- Text Section ---
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SizedBox(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        member.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0F172A),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        member.role.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blueAccent.shade700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Flexible description
                      Expanded(
                        child: Text(
                          member.description,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.blueGrey.shade600,
                          ),
                        ),
                      ),

                      Text(
                        "View Profile →",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}