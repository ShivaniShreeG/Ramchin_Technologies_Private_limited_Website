import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FeaturesPage extends StatefulWidget {
  const FeaturesPage({super.key});

  @override
  State<FeaturesPage> createState() => _FeaturesPageState();
}

class _FeaturesPageState extends State<FeaturesPage> {

  static const roleFeatures = {
    "Admin": {
      "Home": [
        {
          "title": "View Staff & Student Count",
          "description": "Provides a quick overview of total staff and student numbers in the school."
        },
        {
          "title": "View Present & Absent Count (Forenoon & Afternoon)",
          "description": "Shows how many staff and students are present or absent in each session, helping manage daily attendance efficiently."
        },
        {
          "title": "View Class Count",
          "description": "Displays the total number of classes currently registered in the system."
        },
        {
          "title": "View Marked / Not Marked Count (Forenoon & Afternoon)",
          "description": "Tracks which attendance records have been marked and which are pending."
        },
        {
          "title": "View Today’s Message",
          "description": "Shows the daily message or announcement intended for all users."
        },
      ],
      "Attendance": {
        "Staff Attendance": [
          {
            "title": "Mark attendance",
            "description": "Admin can mark staff attendance directly for accurate record keeping."
          },
          {
            "title": "View absentees",
            "description": "Displays the list of staff members absent on a given day."
          },
          {
            "title": "View attendance records",
            "description": "Access historical staff attendance data for monitoring trends or audits."
          },
        ],
        "Student Attendance": [
          {
            "title": "Update attendance",
            "description": "Allows admin to correct or add student attendance entries as needed."
          },
          {
            "title": "View absentees",
            "description": "Shows the list of students absent in each session."
          },
          {
            "title": "View attendance records",
            "description": "Access historical student attendance for analysis or reporting."
          },
          {
            "title": "Generate Monthly & Periodical Attendance Report",
            "description": "Creates comprehensive attendance reports for the school, classes, or individual students."
          },
        ],
      },
      "Manage": {
        "Manage": [
          {
            "title": "Create or Remove Admin, Staff, Student, Class",
            "description": "Admin can add new users or classes, or remove existing ones to keep the system up-to-date."
          },
          {
            "title": "Edit or Announce Messages",
            "description": "Send announcements or edit existing messages for staff and students."
          },
          {
            "title": "Create Holidays",
            "description": "Set school holidays in the calendar, which automatically affects attendance tracking."
          },
        ],
        "Services": [
          {
            "title": "View Leave Requests and Accept / Reject",
            "description": "Manage staff or student leave applications and approve or reject them."
          },
          {
            "title": "View Feedback",
            "description": "Access feedback submitted by staff or students for continuous improvement."
          },
          {
            "title": "Submit Tickets for issues",
            "description": "Raise support tickets for technical or administrative issues."
          },
        ],
        "Bulk Upload": [
          {
            "title": "Upload Admins, Staff, Student via Excel",
            "description": "Simplify onboarding by importing users in bulk using Excel files."
          },
        ],
        "View Profiles": [
          {
            "title": "Admin Profile",
            "description": "View and manage your admin profile details."
          },
          {
            "title": "Staff Profile",
            "description": "Access details of staff members in the system."
          },
          {
            "title": "Student Profile",
            "description": "View student profiles including attendance and personal info."
          },
        ],
        "Reports": [
          {
            "title": "Admin, Staff & Student Lists",
            "description": "Generate lists of all users for record-keeping or export."
          },
          {
            "title": "Periodical, Daily & Community lists",
            "description": "Produce reports for specific periods or communities within the school."
          },
        ],
      },
    },
    "Staff": {
      "Home": [
        {
          "title": "View Today’s Message",
          "description": "Displays announcements from admin or school management."
        },
        {
          "title": "View Student & Class Count",
          "description": "Shows the number of students and classes the staff is responsible for."
        },
        {
          "title": "View Present & Absent Count (Forenoon & Afternoon)",
          "description": "Track daily attendance of your classes in each session."
        },
        {
          "title": "View Marked / Not Marked Count (Forenoon & Afternoon)",
          "description": "Monitor which attendance entries are completed or pending for your classes."
        },
      ],
      "Attendance": {
        "Student Attendance": [
          {
            "title": "Mark attendance",
            "description": "Record attendance for students in your class."
          },
          {
            "title": "View absentees",
            "description": "Quickly see students absent for the day."
          },
          {
            "title": "View attendance records",
            "description": "Check historical attendance data for your students."
          },
          {
            "title": "Generate Monthly & Periodical Attendance Report",
            "description": "Create reports to track attendance trends and performance."
          },
        ],
        "Myself": [
          {
            "title": "View personal attendance",
            "description": "Staff can see their own attendance history."
          },
          {
            "title": "Apply for leave request",
            "description": "Submit leave requests for approval."
          },
          {
            "title": "Check leave approval status",
            "description": "View the status of your submitted leave requests."
          },
        ],
      },
      "Manage": {
        "Manage": [
          {
            "title": "View and edit class-wise timetable",
            "description": "Modify or review timetables assigned to your classes."
          },
          {
            "title": "View student leave requests and Accept / Reject",
            "description": "Approve or reject leave requests from students."
          },
          {
            "title": "Assign homework to students",
            "description": "Create homework tasks for students to complete."
          },
        ],
        "Services": [
          {
            "title": "Raise tickets for issues",
            "description": "Submit support tickets for technical or administrative problems."
          },
        ],
      },
    },
    "Student": {
      "Home": [
        {
          "title": "View Today’s Message",
          "description": "Displays messages or announcements from the school admin."
        },
        {
          "title": "View Class Timetable",
          "description": "See your schedule for classes throughout the week."
        },
      ],
      "Attendance": {
        "Myself": [
          {
            "title": "View personal attendance",
            "description": "Check your own attendance records for accuracy."
          },
          {
            "title": "Apply for leave request",
            "description": "Submit a leave request for approval by staff/admin."
          },
          {
            "title": "Check leave approval status",
            "description": "Monitor the approval status of your leave requests."
          },
        ],
      },
      "HomeWork": [
        {
          "title": "View homework and assignment",
          "description": "Check the homework and assignments given by your teachers."
        },
      ],
    },
  };
  static const roleIcons = {
    "Admin": Icons.admin_panel_settings,
    "Staff": Icons.person,
    "Student": Icons.school,
  };
  static const roleColors = {
    "Admin": Colors.blue,
    "Staff": Colors.orange,
    "Student": Colors.green,
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
                            color: Colors.grey.shade300.withOpacity(0.7),
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
                                    color: Colors.white.withOpacity(0.9),
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
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child:Wrap(
                      spacing: 16,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: roleFeatures.keys.map((role) {
                        final isSelected = selectedRole == role;
                        final roleColor = roleColors[role]!;

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRole = role;
                            });
                            },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? LinearGradient(
                                colors: [
                                  roleColor.withOpacity(0.9),
                                  roleColor,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                                  : null,
                              color: isSelected ? null : Colors.white,
                              borderRadius: BorderRadius.circular(40),
                              boxShadow: [
                                if (isSelected)
                                  BoxShadow(
                                    color: roleColor.withOpacity(0.35),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  )
                                else
                                  const BoxShadow(
                                    color: Color(0x11000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                              ],
                              border: Border.all(
                                color: isSelected
                                    ? Colors.transparent
                                    : roleColor.withOpacity(0.4),
                                width: 1.2,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  roleIcons[role],
                                  size: 18,
                                  color: isSelected ? Colors.white : roleColor,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "View Features - $role",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.5,
                                    color: isSelected ? Colors.white : Colors.black87,
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
                      features: roleFeatures[selectedRole]!,
                      color: roleColors[selectedRole]!,
                      icon: roleIcons[selectedRole]!,
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
  final Map<String, dynamic> features;
  final Color color;
  final IconData icon;

  const RoleContainer({
    super.key,
    required this.role,
    required this.features,
    required this.color,
    required this.icon,
  });

  // YouTube guide links by role
  static const Map<String, String> roleGuideLinks = {
    "Admin": "https://www.youtube.com/watch?v=admin_guide_link",
    "Staff": "https://www.youtube.com/watch?v=staff_guide_link",
    "Student": "https://www.youtube.com/watch?v=student_guide_link",
  };

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
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ===== TOP ROW (Guide Button) =====
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(), // spacer

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color.withOpacity(0.1),
                  foregroundColor: color,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  final String url = roleGuideLinks[role] ?? "https://www.youtube.com/";
                  final Uri uri = Uri.parse(url);
                  if (await canLaunchUrl(uri)) {
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  }
                },
                icon: const Icon(Icons.play_circle_fill, size: 18),
                label: const Text(
                  "Watch Guide",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// ===== CENTERED ROLE TITLE =====
          Center(
            child: Column(
              children: [
                Icon(icon, color: color, size: 40),
                const SizedBox(height: 10),
                Text(
                  getRoleTitle(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// ===== FEATURES =====
          ...features.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FeatureSection(
                featureType: entry.key,
                featureData: entry.value,
              ),
            );
          }),
        ],
      ),
    );
  }
}

class FeatureSection extends StatelessWidget {
  final String featureType;
  final dynamic featureData;

  const FeatureSection({
    super.key,
    required this.featureType,
    required this.featureData,
  });

  @override
  Widget build(BuildContext context) {
    final paragraph = _generateParagraph(featureData);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            featureType,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Flowing paragraph
          Text(
            paragraph,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.black87,
              letterSpacing: 0.2,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  String _generateParagraph(dynamic data) {
    if (data is List) {
      // Join all descriptions into a natural paragraph
      return data.map<String>((item) => item['description'] ?? '').join(' ');
    } else if (data is Map) {
      // Recursively generate text for nested sections
      return data.entries
          .map<String>((entry) => _generateParagraph(entry.value))
          .join(' ');
    }
    return '';
  }
}

