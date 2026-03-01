import 'package:flutter/material.dart';

class WhyChooseRamchinSection extends StatelessWidget {
  const WhyChooseRamchinSection({super.key});

  static const _textDark = Color(0xFF032365);
  static const _textMuted = Color(0xFF4B5563);
  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Responsive settings
    int columns = 4;
    double horizontalPadding = 56.0;
    double verticalPadding = 72.0;
    double headingSize = 38.0;
    double bodySize = 18.0;
    double cardPadding = 32.0;
    double spacing = 32.0;
    double iconSize = 28.0;
    double titleFontSize = 20.0;
    double descriptionFontSize = 16.0;

// Tablet
    if (width < 900) {
      columns = 2;
      horizontalPadding = 32.0;
      verticalPadding = 48.0;
      headingSize = 28.0;
      bodySize = 15.0;
      cardPadding = 20.0;
      spacing = 20.0;
      iconSize = 22.0;
      titleFontSize = 17.0;
      descriptionFontSize = 13.0;
    }

// Mobile
    if (width < 600) {
      columns = 1;
      horizontalPadding = 20.0;
      verticalPadding = 32.0;
      headingSize = 24.0;
      bodySize = 13.0;
      cardPadding = 14.0;
      spacing = 14.0;
      iconSize = 18.0;
      titleFontSize = 15.0;
      descriptionFontSize = 12.0;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _border),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F000000),
                blurRadius: 40,
                offset: Offset(0, 24),
              ),
            ],
          ),
          child: Column(
            children: [
              // Heading
              Text(
                "Why Choose Ramchin",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: headingSize,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.4,
                  color: _textDark,
                ),
              ),
              SizedBox(height: 24.0),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 720),
                child: Text(
                  "We partner with forward-thinking businesses to design, build, and scale secure digital products with long-term impact.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: bodySize,
                    height: 1.5,
                    color: _textMuted,
                  ),
                ),
              ),
              SizedBox(height: spacing),
              // Cards
              LayoutBuilder(
                builder: (context, constraints) {
                  final cardWidth = (constraints.maxWidth - (columns - 1) * spacing) / columns;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    alignment: WrapAlignment.center,
                    children: [
                      _ValueCard(
                        icon: Icons.auto_awesome_outlined,
                        title: "Innovation-First",
                        description: "Modern frameworks, cloud-native systems, and proven engineering practices.",
                        padding: cardPadding,
                        iconSize: iconSize,
                        titleFontSize: titleFontSize,
                        descriptionFontSize: descriptionFontSize,
                      ),
                      _ValueCard(
                        icon: Icons.trending_up_outlined,
                        title: "Built for Scale",
                        description: "Future-ready architectures that grow without rework or instability.",
                        padding: cardPadding,
                        iconSize: iconSize,
                        titleFontSize: titleFontSize,
                        descriptionFontSize: descriptionFontSize,
                      ),
                      _ValueCard(
                        icon: Icons.security_outlined,
                        title: "Enterprise Security",
                        description: "Security-driven development with compliance and data protection at the core.",
                        padding: cardPadding,
                        iconSize: iconSize,
                        titleFontSize: titleFontSize,
                        descriptionFontSize: descriptionFontSize,
                      ),
                      _ValueCard(
                        icon: Icons.support_agent_outlined,
                        title: "Expert Support",
                        description: "Dedicated engineers from Tamil Nadu trusted by global businesses.",
                        padding: cardPadding,
                        iconSize: iconSize,
                        titleFontSize: titleFontSize,
                        descriptionFontSize: descriptionFontSize,
                      ),
                    ].map((card) => SizedBox(
                      width: width < 650 ? double.infinity : cardWidth,
                      child: card,
                    )).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ValueCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final double padding;
  final double iconSize;
  final double titleFontSize;
  final double descriptionFontSize;

  const _ValueCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.padding,
    required this.iconSize,
    required this.titleFontSize,
    required this.descriptionFontSize,
  });

  static const _primary = Color(0xFF2563EB);
  static const _textDark = Color(0xFF111827);
  static const _textMuted = Color(0xFF4B5563);
  static const _border = Color(0xFFE5E7EB);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 24,
            offset: Offset(0, 16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon
          Container(
            width: iconSize * 1.8,
            height: iconSize * 1.8,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, size: iconSize, color: _primary),
          ),
          SizedBox(height: padding * 0.6),
          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: _textDark,
            ),
          ),
          SizedBox(height: padding * 0.3),
          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: descriptionFontSize,
              height: 1.5,
              color: _textMuted,
            ),
          ),
        ],
      ),
    );
  }
}