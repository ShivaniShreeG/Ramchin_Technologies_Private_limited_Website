import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({super.key});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  final List<Map<String, dynamic>> features = const [
    {
      "title": "Inventory Management",
      "description": "Track stock levels, categories, and suppliers in real-time.",
      "icon": Icons.inventory_2,
    },
    {
      "title": "Order Processing",
      "description": "Manage customer orders, deliveries, and returns efficiently.",
      "icon": Icons.shopping_cart,
    },
    {
      "title": "Billing & POS",
      "description": "Process sales quickly with integrated POS and invoicing.",
      "icon": Icons.point_of_sale,
    },
    {
      "title": "Analytics & Reports",
      "description": "Get insights on sales trends, stock performance, and revenue.",
      "icon": Icons.bar_chart_rounded,
    },
    {
      "title": "Staff Management",
      "description": "Assign roles and control access for store staff securely.",
      "icon": Icons.group,
    },
    {
      "title": "24/7 Support",
      "description": "Technical assistance and guidance whenever you need it.",
      "icon": Icons.support_agent,
    },
  ];
  final String youtubeLink = "https://www.youtube.com/";

  late ScrollController _scrollController;
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.offset > 300 && !_showScrollToTop) {
        setState(() => _showScrollToTop = true);
      } else if (_scrollController.offset <= 300 && _showScrollToTop) {
        setState(() => _showScrollToTop = false);
      }
    });
  }


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _floatingBackButton(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
          borderRadius: BorderRadius.circular(50),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.95),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black87,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          /// ===== MAIN CONTENT =====
          SingleChildScrollView(
            controller: _scrollController,
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 45, 24, 40),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF0F2027),
                          Color(0xFF203A43),
                          Color(0xFF2C5364),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            /// GOLD BORDER (sharp stroke)
                            Text(
                              String.fromCharCode(Icons.auto_awesome.codePoint),
                              style: TextStyle(
                                fontSize: 52,
                                fontFamily: Icons.auto_awesome.fontFamily,
                                package: Icons.auto_awesome.fontPackage,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 3
                                  ..color = const Color(0xFFD4AF37),
                              ),
                            ),

                            /// WHITE FILL + WHITE SHADOW
                            Text(
                              String.fromCharCode(Icons.auto_awesome.codePoint),
                              style: TextStyle(
                                fontSize: 52,
                                fontFamily: Icons.auto_awesome.fontFamily,
                                package: Icons.auto_awesome.fontPackage,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    blurRadius: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 20),

                        Text(
                          "Explore the Features of",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            letterSpacing: 0.8,
                          ),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Ramchin Grocery Management",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 18),

                        /// SUBTITLE
                        Text(
                          "A smart platform to manage inventory, sales, orders, and staff efficiently.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            height: 1.6,
                            color: Colors.white60,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: RoleContainer(
                      features:features,
                      youtubeLink: youtubeLink,
                    ),
                  ),


                  const SizedBox(height: 20),

                  /// ===== FOOTER =====
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 28),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF1E3C72),
                          Color(0xFF2A5298),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        // ===== CENTERED PRIVACY BUTTON =====
                        TextButton.icon(
                          onPressed: () async {
                            final Uri url = Uri.parse("https://grocerypolicy.ramchintech.com");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                          icon: const Icon(
                            Icons.privacy_tip,
                            size: 20,
                            color: Color(0xFF1E3C72), // keep icon color
                          ),
                          label: const Text(
                            "Read Your Privacy Policy",
                            style: TextStyle(
                              color: Color(0xFF1E3C72), // keep text color
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                            backgroundColor: Colors.white, // changed to full white
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        const Text(
                          "Manage your grocery store efficiently and keep track of all operations in one place.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text(
                          "© ${DateTime.now().year} Ramchin Technologies Private Limited. All Rights Reserved.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ===== FLOATING BACK BUTTON (TOP LEFT) =====
          Positioned(
            top: 45,
            left: 20,
            child: _floatingBackButton(context),
          ),

          /// ===== SCROLL TO TOP BUTTON (BOTTOM RIGHT) =====
          if (_showScrollToTop)
            Positioned(
              bottom: 40,
              right: 25,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: Colors.white,
                elevation: 6,
                onPressed: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.blue,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class RoleContainer extends StatelessWidget {
  final List<Map<String, dynamic>> features;
  final String youtubeLink;

  const RoleContainer({
    super.key,
    required this.features,
    required this.youtubeLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E3C72).withValues(alpha: 0.08),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF1E3C72).withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ===== HEADER =====
          Stack(
            alignment: Alignment.center,
            children: [

              /// CENTER: ICON + TITLE
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E3C72).withValues(alpha: 0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      FontAwesomeIcons.basketShopping,
                      color: const Color(0xFF1E3C72),
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Text(
                    "Manage Your Grocery Store Effortlessly",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
                      color: Color(0xFF1E3C72),
                    ),
                  ),
                ],
              ),

              /// RIGHT: GUIDE BUTTON
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () async {
                    final Uri url = Uri.parse(youtubeLink);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(
                        url,
                        mode: LaunchMode.externalApplication,
                      );
                    }
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF1E3C72),
                          Color(0xFF2A5298),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.ondemand_video_rounded,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "Watch Guide",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          CarouselSlider.builder(
            itemCount: features.length,
            options: CarouselOptions(
              height: 230,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 4),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              enlargeCenterPage: true,
              viewportFraction: 0.85,
            ),
            itemBuilder: (context, index, realIndex) {
              final item = features[index];
              return _PremiumFeatureCard(
                title: item['title'] ?? '',
                description: item['description'] ?? '',
                icon: item['icon'] as IconData,
                color: const Color(0xFF1E3C72),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PremiumFeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  const _PremiumFeatureCard({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: color.withValues(alpha: 0.14),
          width: 1,
        ),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// HEADER ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              /// ICON
              Container(
                height: 44,
                width: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 22,
                ),
              ),

              const SizedBox(width: 16),

              /// TITLE
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                    letterSpacing: 0.15,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// DESCRIPTION
          Text(
            description,
            style: const TextStyle(
              fontSize: 15.5,
              height: 1.7,
              letterSpacing: 0.05,
              color: Color(0xFF555555),
            ),
          ),
        ],
      ),
    );
  }
}
