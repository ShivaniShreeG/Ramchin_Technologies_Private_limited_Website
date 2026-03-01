import 'package:flutter/material.dart';
import 'dart:ui';

class CoreServicesSection extends StatelessWidget {
  const CoreServicesSection({super.key});

  static const Color accentColor = Color(0xFF0F4C81);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // ===== Responsive values =====
    double horizontalPadding = 60;
    double verticalPadding = 90;
    double headingSize = 38;
    double subtitleSize = 17;
    double gridSpacing = 28;

    // Tablet
    if (screenWidth < 900) {
      horizontalPadding = 40;
      verticalPadding = 64;
      headingSize = 30;
      subtitleSize = 15;
      gridSpacing = 22;
    }

    // Mobile
    if (screenWidth < 600) {
      horizontalPadding = 20;
      verticalPadding = 48;
      headingSize = 24;
      subtitleSize = 14;
      gridSpacing = 16;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Text(
            "What We Do",
            style: TextStyle(
              fontSize: headingSize,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF111827),
            ),
          ),

          const SizedBox(height: 14),

          Container(
            width: 56,
            height: 3,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: 16),

          Text(
            "Core Services That Drive Digital Excellence",
            style: TextStyle(
              fontSize: subtitleSize,
              color: const Color(0xFF6B7280),
            ),
          ),

          const SizedBox(height: 48),

          LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              final columns = width > 1100
                  ? 3
                  : width > 700
                  ? 2
                  : 1;

              return GridView.extent(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                maxCrossAxisExtent: width / columns,
                crossAxisSpacing: gridSpacing,
                mainAxisSpacing: gridSpacing,
                childAspectRatio: width < 600 ? 1.1 : 1.35,
                children: const [
                  ServiceCard(
                    imageUrl: "https://www.ramchintech.com/companyweb/Home_Page/Core_Section/1772008886746-225182865.png",
                    title: "Software Development",
                    description: "Custom software solutions tailored to your business, with end-to-end support from design to deployment and maintenance.",
                  ),
                  ServiceCard(
                    imageUrl: "https://www.ramchintech.com/companyweb/Home_Page/Core_Section/1772008898321-933559156.png",
                    title: "Data Analysis & Science",
                    description: "Transforming raw data into actionable insights through advanced analytics, predictive modeling, and clear data visualization.",
                  ),
                  ServiceCard(
                    imageUrl: "https://www.ramchintech.com/companyweb/Home_Page/Core_Section/1772008914837-632917386.png",
                    title: "Software Testing",
                    description: "Ensuring your software works flawlessly by validating core features with efficient, tailored testing solutions.",
                  ),
                  ServiceCard(
                    imageUrl: "https://www.ramchintech.com/companyweb/Home_Page/Core_Section/1772008919567-702409432.png",
                    title: "IT Advisory Services",
                    description: "Strategic, hands-on technology consulting to align your systems with business goals and industry trends.",
                  ),
                  ServiceCard(
                    imageUrl: "https://www.ramchintech.com/companyweb/Home_Page/Core_Section/1772008924649-14859731.png",
                    title: "Data Warehousing",
                    description: "Modern, scalable data warehousing solutions designed to fit your business needs.",
                  ),
                  ServiceCard(
                    imageUrl: "https://www.ramchintech.com/companyweb/Home_Page/Core_Section/1772008928744-865572385.png",
                    title: "Technology Support Services",
                    description: "High-quality support services delivered using modern tools and technologies.",
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String description;

  const ServiceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
  });

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard> {
  bool hovered = false;
  bool expanded = false;

  bool get isMobile => MediaQuery.of(context).size.width < 800;

  void toggle() {
    if (isMobile) {
      setState(() => expanded = !expanded);
    }
  }

  bool get active => hovered || expanded;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // ===== Responsive card values =====
    double padding = 18;
    double titleSize = 20;
    double descSize = 15;
    double blur = 6;

    // Tablet
    if (width < 900) {
      padding = 16;
      titleSize = 18;
      descSize = 14;
      blur = 5;
    }

    // Mobile
    if (width < 600) {
      padding = 14;
      titleSize = 16;
      descSize = 13;
      blur = 4;
    }

    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: GestureDetector(
        onTap: toggle,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(widget.imageUrl, fit: BoxFit.cover),

              if (active)
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: Container(
                    color: Colors.black.withValues(alpha:0.55),
                  ),
                ),

              AnimatedAlign(
                duration: const Duration(milliseconds: 250),
                alignment: active ? Alignment.center : Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment:
                    active ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        textAlign: active ? TextAlign.center : TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: titleSize,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      if (active) ...[
                        const SizedBox(height: 8),
                        Text(
                          widget.description,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: descSize,
                            height: 1.4,
                          ),
                        ),
                      ],

                      if (isMobile && !expanded) ...[
                        const SizedBox(height: 6),
                        Text(
                          "Read more",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: descSize - 1,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
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