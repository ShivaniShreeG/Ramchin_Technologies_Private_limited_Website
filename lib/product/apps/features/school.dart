import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({super.key});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {
  static const Map<String, List<Map<String, dynamic>>> roleFeatureOverview = {
    "Admin": [
      {
        "title": "AI-Powered Smart Dashboard",
        "description":
        "Real-time visibility into attendance, fees, academic performance, financial flow, and institutional analytics — all from one powerful command center.",
        "icon": Icons.dashboard_customize_rounded,
      },
      {
        "title": "Complete Institution Control",
        "description":
        "Manage admins, staff, students, classes, and permissions with advanced access control and bulk onboarding via Excel integration.",
        "icon": Icons.admin_panel_settings_rounded,
      },
      {
        "title": "Academic Automation Suite",
        "description":
        "Automated exam result processing with instant pass and fail analysis, ranking, timetable management, and result publishing seamlessly integrated with attendance and reports.",
        "icon": Icons.school_rounded,
      },
      {
        "title": "Advanced Finance Management",
        "description":
        "End-to-end fee tracking (Term, RTE, Bus), income-expense monitoring, financial reporting, and institutional account transparency.",
        "icon": Icons.account_balance_wallet_rounded,
      },
      {
        "title": "Attendance Intelligence System",
        "description":
        "Session-wise attendance tracking (FN/AN), absentee analytics, long absentee detection, and automated reporting tools.",
        "icon": Icons.fact_check_rounded,
      },
      {
        "title": "Unified Communication & Support",
        "description":
        "Holiday announcements, official circular distribution, event publishing, and integrated ticket management.",
        "icon": Icons.support_agent_rounded,
      },
    ],
    "Staff": [
      {
        "title": "Classroom Command Center",
        "description":
        "Manage classes, monitor student performance, and track attendance seamlessly from a personalized teaching dashboard.",
        "icon": Icons.class_rounded,
      },
      {
        "title": "Smart Attendance Tracking",
        "description":
        "Quick student attendance marking, absentee tracking, and automated attendance report generation.",
        "icon": Icons.check_circle_outline_rounded,
      },
      {
        "title": "Academic Planner & Timetable",
        "description":
        "View and manage class timetables, schedule lessons, and organize academic activities efficiently.",
        "icon": Icons.calendar_month_rounded,
      },
      {
        "title": "Homework & Assignment Hub",
        "description":
        "Assign, manage, and track homework with streamlined digital workflow.",
        "icon": Icons.assignment_rounded,
      },
      {
        "title": "Leave & Personal Management",
        "description":
        "Apply for leave, monitor approval status, and access personal attendance records anytime.",
        "icon": Icons.event_note_rounded,
      },
      {
        "title": "Support & Feedback System",
        "description":
        "Raise technical tickets, provide feedback, and stay connected with administration.",
        "icon": Icons.feedback_rounded,
      },
    ],
    "Student": [
      {
        "title": "Personal Learning Dashboard",
        "description":
        "Access attendance, class timetable, announcements, exam schedules, and real-time academic updates from a centralized student portal.",
        "icon": Icons.space_dashboard_rounded,
      },
      {
        "title": "Attendance & Academic Insights",
        "description":
        "Track session-wise attendance, monitor subject-wise marks, view rankings, and analyze overall academic performance.",
        "icon": Icons.analytics_rounded,
      },
      {
        "title": "Examination & Results Center",
        "description":
        "View exam timetables, check subject-wise marks, track pass/fail status, and monitor performance rankings instantly.",
        "icon": Icons.fact_check_rounded,
      },
      {
        "title": "Fee Management & Status Tracking",
        "description":
        "Monitor term, bus, and other fee payments with clear visibility of paid, pending, and outstanding balances.",
        "icon": Icons.account_balance_wallet_rounded,
      },
      {
        "title": "Digital Homework Hub",
        "description":
        "Access assignments, homework tasks, submission instructions, and academic resources shared by teachers.",
        "icon": Icons.menu_book_rounded,
      },
    ],
  };

  String _getYouTubeLink(String role) {
    switch (role) {
      case "Admin":
        return "https://www.youtube.com/watch?v=ADMIN_GUIDE";
      case "Staff":
        return "https://www.youtube.com/watch?v=STAFF_GUIDE";
      case "Student":
        return "https://www.youtube.com/watch?v=STUDENT_GUIDE";
      default:
        return "https://www.youtube.com/";
    }
  }

  static const roleIcons = {
    "Admin": Icons.admin_panel_settings,
    "Staff": Icons.person,
    "Student": Icons.school,
  };

  String selectedRole = "Admin";
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

  void _showPricingDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    double monthly = 0;
    double yearly = 0;
    double gst = 0;
    double total = 0;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            void calculate() {
              final int strength = int.tryParse(controller.text) ?? 0;

              monthly = strength * 5;
              yearly = monthly * 10; // 2 months free
              gst = yearly * 0.18;
              total = yearly + gst;

              setState(() {});
            }

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 340),
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.blue.shade700, Colors.blue.shade400],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Center(
                              child: Text(
                                "School Pricing Calculator",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          const Text(
                            "₹5 per student per month\nYearly: Pay only 10 months (2 Months FREE)",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Input
                          TextField(
                            controller: controller,
                            keyboardType: TextInputType.number,
                            onChanged: (_) => calculate(),
                            decoration: InputDecoration(
                              hintText: "Enter Student Strength",
                              hintStyle: TextStyle(color: Colors.blueGrey.shade400),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blueGrey.shade100),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(color: Colors.blue.shade400, width: 2),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                            ),
                          ),

                          if (yearly > 0) ...[
                            const SizedBox(height: 24),
                            Divider(color: Colors.grey.shade300),
                            const SizedBox(height: 12),

                            _dialogRow("Monthly (Inc. GST)", "₹ ${(monthly * 1.18).toStringAsFixed(0)}"),
                            const SizedBox(height: 10),
                            _dialogRow("Yearly (Inc. GST)", "₹ ${total.toStringAsFixed(0)}", bold: true),

                            const SizedBox(height: 16),
                            Text(
                              "Includes 18% GST",
                              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                            ),
                          ],

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),

                    // Close icon
                    Positioned(
                      top: 12,
                      right: 12,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade300.withValues(alpha: 0.7),
                          ),
                          child: const Icon(
                            Icons.close,
                            size: 20,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _dialogRow(String title, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.w500,
              fontSize: 14,
              color: Colors.blueGrey.shade800,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.w600,
              fontSize: 14,
              color: Colors.blue.shade700,
            ),
          ),
        ],
      ),
    );
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
                          "Ramchin Smart School",
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
                          "A complete digital ecosystem for\nAdmins, Staff, and Students",
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

                  /// FILTER BUTTONS
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Wrap(
                      spacing: 18,
                      runSpacing: 14,
                      alignment: WrapAlignment.center,
                      children: roleFeatureOverview.keys.map((role) {
                        final isSelected = selectedRole == role;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRole = role;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 26, vertical: 14),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? const LinearGradient(
                                colors: [
                                  Color(0xFF1E3C72),
                                  Color(0xFF2A5298),
                                ],
                              )
                                  : null,
                              color: isSelected ? null : Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFD4AF37) // gold accent
                                    : const Color(0xFF1E3C72).withValues(alpha: 0.4),
                                width: 1.2,
                              ),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: const Color(0xFF1E3C72).withValues(alpha: 0.25),
                                    blurRadius: 12,
                                    offset: const Offset(0, 5),
                                  )
                                else
                                  const BoxShadow(
                                    color: Color(0x11000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  roleIcons[role],
                                  size: 18,
                                  color: isSelected
                                      ? Colors.white
                                      : const Color(0xFF1E3C72),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  role,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.4,
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF1E3C72),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: RoleContainer(
                      role: selectedRole,
                      features: _FeaturesPageState.roleFeatureOverview[selectedRole] ?? [],
                      icon: _FeaturesPageState.roleIcons[selectedRole]!,
                      youtubeLink: _getYouTubeLink(selectedRole),
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

                    /// ================== TOP SECTION ==================
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        /// ===== LEFT SIDE =====
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const Text(
                                "Quick Links",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(height: 16),

                              TextButton.icon(
                                onPressed: () async {
                                  final Uri url =
                                  Uri.parse("https://privatepolicy.ramchintech.com");
                                  if (await canLaunchUrl(url)) {
                                    await launchUrl(
                                      url,
                                      mode: LaunchMode.externalApplication,
                                    );
                                  }
                                },
                                icon: const Icon(Icons.privacy_tip,
                                    size: 18, color: Colors.white),
                                label: const Text(
                                  "Privacy Policy",
                                  style: TextStyle(color: Colors.white70),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                              ),

                              const SizedBox(height: 8),

                              TextButton.icon(
                                onPressed: () {
                                  _showPricingDialog(context);
                                },
                                icon: const Icon(Icons.calculate,
                                    size: 18, color: Colors.white),
                                label: const Text(
                                  "School Pricing",
                                  style: TextStyle(color: Colors.white70),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Vertical Divider
                        Container(
                          height: 120,
                          width: 1,
                          color: Colors.white24,
                        ),

                        const SizedBox(width: 24),

                        /// ===== RIGHT SIDE =====
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight, // push whole block to right
                            child: SizedBox(
                              width: 200, // fixed width for clean alignment
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // align all text same
                                children: [

                                  const Text(
                                    "Resources",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  /// Brochure
                                  TextButton.icon(
                                    onPressed: () async {
                                      final Uri url =
                                      Uri.parse("https://yourwebsite.com/brochure.pdf");
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(
                                          url,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.menu_book_rounded,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "View Brochure",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  /// User Manual
                                  TextButton.icon(
                                    onPressed: () async {
                                      final Uri url =
                                      Uri.parse("https://yourwebsite.com/manual.pdf");
                                      if (await canLaunchUrl(url)) {
                                        await launchUrl(
                                          url,
                                          mode: LaunchMode.externalApplication,
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Icons.library_books_rounded,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    label: const Text(
                                      "User Manual",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    const Divider(color: Colors.white24),

                    const SizedBox(height: 20),

                    const Text(
                      "Empowering Education Through Smart Digital Solutions",
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
  final String role;
  final IconData icon;
  final List<Map<String, dynamic>> features;
  final String youtubeLink;

  const RoleContainer({
    super.key,
    required this.role,
    required this.icon,
    required this.features,
    required this.youtubeLink,
  });

  String getRoleTitle() {
    switch (role) {
      case "Admin":
        return "Administrator Control Panel";
      case "Staff":
        return "Staff Management Portal";
      case "Student":
        return "Student Experience Hub";
      default:
        return role;
    }
  }

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
                      icon,
                      color: const Color(0xFF1E3C72),
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Text(
                    getRoleTitle(),
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
