import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInfoSection extends StatelessWidget {
  const ContactInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
        child:  _MainHeading(title: "Headquarters"),
        ),
        const SizedBox(height: 24),

        _detailRow("Company", "Ramchin Technologies Private Limited"),
        _detailRow("CIN", "U62013TN2025PTC179750"),
        _detailRow(
          "Phone",
          "+91 86108 19018\n+91 89039 72502",
          onTap: () => _launch("tel:+918610819018"),
        ),
        _detailRow(
          "Email",
          "ramchintech@gmail.com",
          onTap: () => _launch("mailto:ramchintech@gmail.com"),
        ),
        _detailRow(
          "Address",
          "1/139-15, I Street,\nKurunji Nagar,\nVeerapandianpatnam,\nTiruchendur,\nThoothukudi District,\nTamil Nadu – 628216,\nIndia",
        ),

        const SizedBox(height: 40),
        Divider(color: Colors.blueGrey.shade100),
        const SizedBox(height: 32),
Center(
        child:  _MainHeading(title: "Follow Our Journey"),
),
        const SizedBox(height: 20),
        const SocialLinks(),
      ],
    );
  }

  Widget _detailRow(String label, String value, {VoidCallback? onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.blueGrey.shade400,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF334155),
                height: 1.6,
              ),
            ),
          ),
          if (onTap != null)
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Icon(
                  label == "Phone"
                      ? Icons.phone_rounded
                      : Icons.email_rounded,
                  size: 18,
                  color: const Color(0xFF2563EB),
                ),
              ),
            ),
        ],
      ),
    );
  }

  static Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

/* ================= Headings ================= */

class _MainHeading extends StatelessWidget {
  final String title;
  const _MainHeading({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w900,
        color: Color(0xFF0F172A),
        letterSpacing: -0.4,
      ),
    );
  }
}

/* ================= Social Links ================= */

class SocialLinks extends StatelessWidget {
  const SocialLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _social(FontAwesomeIcons.linkedinIn, const Color(0xFF0077B5),
            "https://www.linkedin.com/company/ramchin-technologies-private-limited"),
        _social(FontAwesomeIcons.github, const Color(0xFF181717),
            "https://github.com/ramchintech"),
        _social(FontAwesomeIcons.upwork, const Color(0xFF14A800),
            "https://www.upwork.com/agencies/1932763521194595857"),
        _social(FontAwesomeIcons.youtube, const Color(0xFFFF0000),
            "https://www.youtube.com/@ramchintech"),
        _social(FontAwesomeIcons.instagram, const Color(0xFFE4405F),
            "https://www.instagram.com/company/ramchin-technologies-private-limited"),
        _social(FontAwesomeIcons.facebookF, const Color(0xFF1877F2),
            "https://www.facebook.com/company/ramchin-technologies-private-limited"),
        _social(FontAwesomeIcons.xTwitter, Colors.black,
            "https://www.twitter.com/company/ramchin-technologies-private-limited"),
      ],
    );
  }

  Widget _social(IconData icon, Color color, String url) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => launchUrl(Uri.parse(url)),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.blueGrey.shade50),
          ),
          child: FaIcon(icon, size: 18, color: color),
        ),
      ),
    );
  }
}