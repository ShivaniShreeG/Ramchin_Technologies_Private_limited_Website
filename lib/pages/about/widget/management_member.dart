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
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FA), // Modern cool-grey background
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
          const SizedBox(height: 60),

          // --- Member Grid ---
          Wrap(
            spacing: 30,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: members.map((member) => _buildMemberCard(member)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard(ManagementMember member) {
    return Container(
      width: 300,
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
          // Top Decorative Header with Circle Image
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              // Subtle background shape
              Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent.shade100.withOpacity(0.1), Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                ),
              ),
              // Circular Image with Border
              Positioned(
                top: 30,
                child: Container(
                  padding: const EdgeInsets.all(4), // The white ring
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 10)
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade100,
                    backgroundImage: NetworkImage(member.image),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 100), // Space for the positioned circle

          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
            child: Column(
              children: [
                Text(
                  member.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  member.role.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blueAccent.shade700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  member.description,
                  textAlign: TextAlign.center,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: Colors.blueGrey.shade600,
                  ),
                ),
                const SizedBox(height: 24),

                // Refined Profile Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _openPdf(member.pdfPath),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A), // Dark Navy
                      foregroundColor: Colors.white,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "View Profile",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}