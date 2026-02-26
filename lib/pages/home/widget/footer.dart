import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class Footer extends StatelessWidget {
  final VoidCallback? onContactNavigate;
  const Footer({super.key, this.onContactNavigate});

  static const Color _bgDeep      = Color(0xFF0A0C10);
  static const Color _accent      = Color(0xFF38BDF8);
  static const Color _textPrimary = Color(0xFFF1F5F9);
  static const Color _textMuted   = Color(0xFF94A3B8);
  static const String _siteVersion = "v2.1.0";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isMobile = width < 900;

    return Column(
      children: [
        // 1. Spacing above the footer
        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: _bgDeep,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            border: Border(
              top: BorderSide(color: Colors.white10, width: 0.5),
              left: BorderSide(color: Colors.white10, width: 0.1),
              right: BorderSide(color: Colors.white10, width: 0.1),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 20,
            horizontal: isMobile ? 24 : width * 0.08,
          ),
          child: Column(
            children: [
              // 2. Center White Line (Desktop Only)
              if (!isMobile) ...[
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.white70, // Subtle white line
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ],

              // Main Footer Content
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: isMobile ? _mobileLayout() : _desktopLayout(),
              ),
            ],
          ),
        ),
        _buildBaseline(),
      ],
    );
  }

  Widget _desktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 3, child: _brandBlock()),
        const SizedBox(width: 40),
        Expanded(flex: 3, child: _linksBlock()),
        const SizedBox(width: 40),
        Expanded(flex: 3, child: _contactBlock()),
      ],
    );
  }

  Widget _mobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _brandBlock(),
        const SizedBox(height: 30), // Reduced from 50
        const Divider(color: Colors.white10),
        const SizedBox(height: 30), // Reduced from 50
        _linksBlock(),
        const SizedBox(height: 30), // Reduced from 50
        const Divider(color: Colors.white10),
        const SizedBox(height: 30), // Reduced from 50
        _contactBlock(),
        const SizedBox(height: 30), // Reduced from 50
      ],
    );
  }
  // ────────────────── Semantic Blocks ──────────────────

  Widget _brandBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Refined Contact Us Header with Navigation Ability
        _sectionHeader("FOR SUPPORT"),
        const SizedBox(height: 24),
        _contactItem(Icons.chat_bubble_outline_rounded, "+91 86108 19018", "tel:+918610819018"),
        _contactItem(Icons.phone_in_talk_outlined, "+91 89039 72502", "tel:+918903972502"),
        _contactItem(Icons.email_outlined, "ramchintech@gmail.com", "mailto:ramchintech@gmail.com"),
        const SizedBox(height: 24),
        // NEW HEADER BEFORE BROCHURE
        _sectionHeader("RESOURCES"),
        const SizedBox(height: 24),
        const _BrochureButton(
          url: "https://www.ramchintech.com/companyweb/Brochure/Company/1771825008992-944357908.pdf",
        ),
      ],
    );
  }

  Widget _linksBlock() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("CONNECT WITH US ON"),
        const SizedBox(height: 24),
        const Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _SocialIcon(FontAwesomeIcons.linkedinIn, "https://www.linkedin.com/company/ramchin-technologies-private-limited"),
            _SocialIcon(FontAwesomeIcons.github, "https://github.com/ramchintech"),
            _SocialIcon(FontAwesomeIcons.youtube, "https://www.youtube.com/@ramchintech"),
            _SocialIcon(FontAwesomeIcons.upwork, "https://www.upwork.com/agencies/1932763521194595857"),
            _SocialIcon(FontAwesomeIcons.facebook, "https://www.facebook.com/company/ramchin-technologies-private-limited"),
            _SocialIcon(FontAwesomeIcons.instagram, "https://www.instagram.com/company/ramchin-technologies-private-limited"),
            _SocialIcon(FontAwesomeIcons.xTwitter, "https://www.twitter.com/company/ramchin-technologies-private-limited"),
          ],
        ),
        const SizedBox(height: 40),
        _sectionHeader("LEGAL"),
        const SizedBox(height: 20),
        _HoverLink(text: "Privacy Policy", url: "https://privacy_policy.ramchintech.com"),
        const SizedBox(height: 12),
        _HoverLink(text: "Terms of Use", url: "https://terms_of_use.ramchintech.com"),
      ],
    );
  }

  Widget _contactBlock() {
    const String cinNumber = "U62013TN2025PTC179750";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionHeader("OFFICE HEADQUARTERS"),
        const SizedBox(height: 24),
        const Text(
          "1/396-15, 1st Street, Kurunji Nagar,\nVeerapandianpatnam, Tiruchendur,\nThoothukudi - 628216",
          style: TextStyle(color: _textMuted, fontSize: 14, height: 1.6),
        ),
        const SizedBox(height: 16),

        // CIN Badge - Now Copyable
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              Clipboard.setData(const ClipboardData(text: cinNumber));
              // Optional: You can add a ScaffoldMessenger here to show "Copied!"
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _accent.withOpacity(0.05),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: _accent.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "CIN: $cinNumber",
                    style: TextStyle(color: _accent, fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 6),
                  Icon(Icons.copy_rounded, color: _accent.withOpacity(0.5), size: 14),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(height: 28),

        // 📍 High-End Map Action Tile
        _professionalMapLink(),
      ],
    );
  }

  Widget _professionalMapLink() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launch("https://maps.app.goo.gl/YTSDM2xsL88rFi3m6"),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03), // Subtle glass effect
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.08), width: 1),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Left Accent Bar (Indicator of Action)
                  Container(
                    width: 4,
                    color: _accent.withOpacity(0.6),
                  ),

                  // 2. Main Content Area
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: Row(
                        children: [
                          // The Icon with a soft glow background
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: _accent.withOpacity(0.08),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                                Icons.directions_outlined,
                                color: _accent,
                                size: 22
                            ),
                          ),
                          const SizedBox(width: 16),

                          // Text Stack
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "OFFICE NAVIGATION",
                                  style: TextStyle(
                                    color: _accent,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  "View on Google Maps",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Trailing Arrow with modern styling
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white10),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_right_rounded,
                              color: Colors.white38,
                              size: 18,
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
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: _textPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w900,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _contactItem(IconData icon, String label, String url) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _launch(url),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: _accent),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(color: _textPrimary, fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildBaseline() {
    return Container(
      width: double.infinity,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: [
          Image.network(
            "https://www.ramchintech.com/companyweb/Logo/Company/1772117844632-721256852.png",
            height: 55,
            opacity: const AlwaysStoppedAnimation(0.8),
          ),
          const SizedBox(height: 10),

          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 600;

              return Text(
                isMobile
                    ? "© 2026 Ramchin Technologies Private Limited.\nAll rights reserved. • $_siteVersion"
                    : "© 2026 Ramchin Technologies Private Limited. All rights reserved. | $_siteVersion",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 11,
                  letterSpacing: 0.5,
                  height: 1.5,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  static Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri)) debugPrint("Could not launch $url");
  }
}

// ────────────────── Interaction Components ──────────────────

class _HoverLink extends StatefulWidget {
  final String text;
  final String url;
  const _HoverLink({required this.text, required this.url});

  @override
  State<_HoverLink> createState() => _HoverLinkState();
}

class _HoverLinkState extends State<_HoverLink> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => Footer._launch(widget.url),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: _isHovered ? Footer._accent : Footer._textMuted,
                fontSize: 13,
              ),
              child: Text(widget.text),
            ),
            const SizedBox(height: 2),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 1,
              width: _isHovered ? 24 : 0,
              color: Footer._accent,
            )
          ],
        ),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  final String url;
  const _SocialIcon(this.icon, this.url);

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;

  Color _getBrandColor() {
    if (widget.icon == FontAwesomeIcons.linkedinIn) return const Color(0xFF0077B5);
    // GitHub & X: White Background on hover
    if (widget.icon == FontAwesomeIcons.github)     return Colors.white70;
    if (widget.icon == FontAwesomeIcons.xTwitter)   return const Color(0xFFFFFFFF);

    if (widget.icon == FontAwesomeIcons.youtube)    return const Color(0xFFFF0000);
    if (widget.icon == FontAwesomeIcons.upwork)     return const Color(0xFF14A800);
    if (widget.icon == FontAwesomeIcons.facebook)   return const Color(0xFF1877F2);
    if (widget.icon == FontAwesomeIcons.instagram)  return const Color(0xFFE4405F);

    return Footer._accent;
  }

  @override
  Widget build(BuildContext context) {
    final Color brandColor = _getBrandColor();

    // Check if it's one of the "White Background" brands
    final bool isWhiteHover = (widget.icon == FontAwesomeIcons.github ||
        widget.icon == FontAwesomeIcons.xTwitter);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => Footer._launch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _isHovered ? brandColor : Colors.white.withOpacity(0.03),
            shape: BoxShape.circle,
            border: Border.all(
              color: _isHovered ? brandColor : Colors.white10,
            ),
            // White brands get a subtle white glow, others get colored glow
            boxShadow: _isHovered
                ? [
              BoxShadow(
                  color: brandColor.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 1
              )
            ]
                : [],
          ),
          child: FaIcon(
            widget.icon,
            size: 16,
            // Logic: If hovered and it's a white-background brand, make icon BLACK.
            // Otherwise, make it white.
            color: _isHovered
                ? (isWhiteHover ? Colors.black : Colors.white)
                : Colors.white70,
          ),
        ),
      ),
    );
  }
}

class _BrochureButton extends StatefulWidget {
  final String url;
  const _BrochureButton({required this.url});

  @override
  State<_BrochureButton> createState() => _BrochureButtonState();
}

class _BrochureButtonState extends State<_BrochureButton> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => Footer._launch(widget.url),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: _isHovered ? Footer._accent : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _isHovered ? Footer._accent : Colors.white24),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.picture_as_pdf_rounded, size: 16, color: _isHovered ? Colors.white : Footer._accent),
              const SizedBox(width: 10),
              Text(
                "COMPANY BROCHURE",
                style: TextStyle(
                  color: _isHovered ? Colors.white : Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}