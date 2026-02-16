import 'package:flutter/material.dart';
import 'package:ramchin_web/pages/product/features_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'dart:html' as html;

import '../widgets/windowsbutton.dart';

class SchoolPage extends StatefulWidget {
  const SchoolPage({super.key});

  @override
  State<SchoolPage> createState() => _SchoolPageState();
}

class _SchoolPageState extends State<SchoolPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late Animation<Offset> _textSlideAnimation;
  final String pdfPath = 'assets/ramchin_smart_school_manual.pdf';

  Future<void> _openPdf() async {
    final url = '${Uri.base.origin}/$pdfPath';
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } else {
      print('Could not open PDF');
    }
  }

  void _launchAppStore() async {
    const url = 'https://apps.apple.com/app/idYOUR_APP_ID';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _launchPlayStore() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.demo.ramchin_smart_school&pcampaignid=web_share';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _launchWindowsStore() async {
    const url = 'https://www.microsoft.com/store/apps/9YOUR_WINDOWS_APP_ID';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _launchWebsite() async {
    const url = 'https://smartschool.ramchintech.com';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void initState() {
    super.initState();
    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(-0.5, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _textAnimationController,
            curve: Curves.easeOut,
          ),
        );
    _textAnimationController.forward();
  }

  @override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ramchin Smart School"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// HERO SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  bool isWide = constraints.maxWidth > 800;
                  return isWide
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: SlideTransition(
                          position: _textSlideAnimation,
                          child: _buildHeroText(isWide),
                        ),
                      ),
                      const SizedBox(width: 30),
                      Expanded(flex: 1, child: _buildHeroImage(isWide)),
                    ],
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildHeroImage(isWide),
                      const SizedBox(height: 20),
                      SlideTransition(
                        position: _textSlideAnimation,
                        child: _buildHeroText(isWide),
                      ),
                    ],
                  );
                },
              ),
            ),

            /// DEMO LOGIN SECTION
            Container(
              width: double.infinity,
              color: Colors.blue.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Explore Our School App Live",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Login with demo accounts and explore Attendance, Homework, Assignments, and more.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Download For Ramchin Smart School App.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _openPdf,
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                    label: const Text(
                      'Open User Manual',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 14,
                      ),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      shadowColor: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ✅ 4 UNIFORM SIZE BUTTONS WITH REDUCED SHADOWS
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Android Download Card - FIXED SIZE
                      _buildUniformButton(
                        onTap: _launchPlayStore,
                        icon: Icons.android,
                        color: Colors.green,
                        label: "Android",
                      ),
                      const SizedBox(width: 20),

                      /// iOS Download Card - FIXED SIZE
                      _buildUniformButton(
                        onTap: _launchAppStore,
                        icon: Icons.apple,
                        color: Colors.white,
                        label: "iOS",
                        iconColor: Colors.black,
                      ),
                      const SizedBox(width: 20),

                      /// Windows Button - FIXED SIZE
                      SizedBox(
                        width: 80,
                        child: WindowsDownloadButton(
                          onTap: _launchWindowsStore,
                        ),
                      ),
                      const SizedBox(width: 20),

                      /// Website Button - FIXED SIZE
                      _buildUniformButton(
                        onTap: _launchWebsite,
                        icon: Icons.language,
                        color: Colors.white,
                        label: "Website",
                        iconColor: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ApkDownloadButton(),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      // Push Privacy Policy route.
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: const Text(
                        "Privacy Policy",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        alignment: WrapAlignment.center,
                        children: const [
                          DemoCard(
                            role: "Admin",
                            schoolid: "2",
                            login: "demoadmin",
                            password: "demo@123",
                          ),
                          DemoCard(
                            role: "Staff",
                            schoolid: "2",
                            login: "9876543210",
                            password: "demo@123",
                          ),
                          DemoCard(
                            role: "Student",
                            schoolid: "2",
                            login: "2025000",
                            password: "demo@123",
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ UNIFORM BUTTON BUILDER - SAME SIZE, REDUCED SHADOWS
  Widget _buildUniformButton({
    required VoidCallback onTap,
    required IconData icon,
    required Color color,
    required String label,
    Color? iconColor,
    bool showClickCursor = true,
  }) {
    return MouseRegion(
      cursor: showClickCursor ? SystemMouseCursors.click : MouseCursor.defer,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          children: [
            Container(
              width: 80, // ✅ FIXED WIDTH
              height: 80, // ✅ FIXED HEIGHT
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05), // ✅ REDUCED SHADOW
                    blurRadius: 4, // ✅ REDUCED BLUR
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 40, // ✅ UNIFORM ICON SIZE
                color: iconColor ?? Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Extracted Widgets for readability
  Widget _buildHeroText(bool isWide) {
    return Column(
      crossAxisAlignment: isWide
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        const Icon(Icons.school, size: 80, color: Colors.blue),
        const SizedBox(height: 20),
        Text(
          "Smart Solutions for Smarter Schools",
          textAlign: isWide ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 42 : 28,
            color: Colors.blue.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Attendance, Homework, Assignments and more –\nfor Admins, Staff and Students.",
          textAlign: isWide ? TextAlign.start : TextAlign.center,
          style: TextStyle(fontSize: isWide ? 20 : 16, color: Colors.black87),
        ),
        const SizedBox(height: 25),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeaturesPage()),
            );
          },
          icon: const Icon(Icons.explore, size: 20),
          label: const Text(
            "Explore Features",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroImage(bool isWide) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      height: screenWidth > 1024
          ? MediaQuery.sizeOf(context).height * 0.45
          : screenWidth > 600
          ? MediaQuery.sizeOf(context).height * 0.43
          : MediaQuery.sizeOf(context).height * 0.3,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.transparent),
      child: AutoPlayVideo(),
    );
  }
}

class DemoCard extends StatelessWidget {
  final String role;
  final String login;
  final String password;
  final String schoolid;

  const DemoCard({
    super.key,
    required this.role,
    required this.login,
    required this.password,
    required this.schoolid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: 300,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              role,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "School ID: $schoolid",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 5),
            Text(
              "User ID: $login",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 5),
            Text(
              "Password: $password",
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class ApkDownloadButton extends StatelessWidget {
  const ApkDownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final apkPath = 'assets/apk/ramchinsmartschool.apk';
        html.AnchorElement anchor = html.AnchorElement(href: apkPath)
          ..setAttribute('download', 'ramchin_smart_school.apk')
          ..click();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
      ),
      child: const Text(
        "Download for apk",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AutoPlayVideo extends StatefulWidget {
  @override
  _AutoPlayVideoState createState() => _AutoPlayVideoState();
}

class _AutoPlayVideoState extends State<AutoPlayVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/screenV.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      )
          : CircularProgressIndicator(),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:ramchin_web/pages/product/features_page.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:video_player/video_player.dart';
// import 'widget/windows_buttons.dart';
//
// class SchoolPage extends StatefulWidget {
//   const SchoolPage({super.key});
//
//   @override
//   State<SchoolPage> createState() => _SchoolPageState();
// }
//
// class _SchoolPageState extends State<SchoolPage>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _textAnimationController;
//   late Animation<Offset> _textSlideAnimation;
//   final String pdfPath = 'assets/ramchin_smart_school_manual.pdf';
//
//   Future<void> _openPdf() async {
//     final url = '${Uri.base.origin}/$pdfPath';
//     final uri = Uri.parse(url);
//
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(
//         uri,
//         mode: LaunchMode.externalApplication,
//       );
//     } else {
//       print('Could not open PDF');
//     }
//   }
//
//   void _launchAppStore() async {
//     const url = 'https://apps.apple.com/app/idYOUR_APP_ID';
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     }
//   }
//
//   void _launchPlayStore() async {
//     const url =
//         'https://play.google.com/store/apps/details?id=com.demo.ramchin_smart_school&pcampaignid=web_share';
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     }
//   }
//
//   void _launchWindowsStore() async {
//     const url = 'https://www.microsoft.com/store/apps/9YOUR_WINDOWS_APP_ID';
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     }
//   }
//
//   void _launchWebsite() async {
//     const url = 'https://smartschool.ramchintech.com';
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _textAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 1000),
//     );
//     _textSlideAnimation =
//         Tween<Offset>(begin: const Offset(-0.5, 0), end: Offset.zero).animate(
//           CurvedAnimation(
//             parent: _textAnimationController,
//             curve: Curves.easeOut,
//           ),
//         );
//     _textAnimationController.forward();
//   }
//
//   @override
//   void dispose() {
//     _textAnimationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text("Ramchin Smart School"),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /// HERO SECTION
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
//               child: LayoutBuilder(
//                 builder: (context, constraints) {
//                   bool isWide = constraints.maxWidth > 800;
//                   return isWide
//                       ? Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Expanded(
//                         flex: 1,
//                         child: SlideTransition(
//                           position: _textSlideAnimation,
//                           child: _buildHeroText(isWide),
//                         ),
//                       ),
//                       const SizedBox(width: 30),
//                       Expanded(flex: 1, child: _buildHeroImage(isWide)),
//                     ],
//                   )
//                       : Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       _buildHeroImage(isWide),
//                       const SizedBox(height: 20),
//                       SlideTransition(
//                         position: _textSlideAnimation,
//                         child: _buildHeroText(isWide),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),
//
//             /// DEMO LOGIN SECTION
//             Container(
//               width: double.infinity,
//               color: Colors.blue.shade50,
//               padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     "Explore Our School App Live",
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blue,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   const Text(
//                     "Login with demo accounts and explore Attendance, Homework, Assignments, and more.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 20),
//                   const Text(
//                     "Download For Ramchin Smart School App.",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton.icon(
//                     onPressed: _openPdf,
//                     icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
//                     label: const Text(
//                       'Open User Manual',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 15,
//                         vertical: 14,
//                       ),
//                       backgroundColor: Colors.blue,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       elevation: 6,
//                       shadowColor: Colors.blueAccent,
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   // ✅ 4 UNIFORM SIZE BUTTONS WITH REDUCED SHADOWS
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//
//                       _buildUniformButton(
//                         onTap: _launchPlayStore,
//                         icon: Icons.android,
//                         color: Colors.green,
//                         label: "Android",
//                       ),
//                       const SizedBox(width: 20),
//
//                       /// iOS Download Card - FIXED SIZE
//                       _buildUniformButton(
//                         onTap: _launchAppStore,
//                         icon: Icons.apple,
//                         color: Colors.white,
//                         label: "iOS",
//                         iconColor: Colors.black,
//                       ),
//                       const SizedBox(width: 20),
//
//                       /// Windows Button - FIXED SIZE
//                       SizedBox(
//                         width: 80,
//                         child: WindowsDownloadButton(
//                           onTap: _launchWindowsStore,
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//
//                       _buildUniformButton(
//                         onTap: _launchWebsite,
//                         icon: Icons.language,
//                         color: Colors.white,
//                         label: "Website",
//                         iconColor: Colors.black,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   GestureDetector(
//                     onTap: () {
//                       // Push Privacy Policy route.
//                     },
//                     child: MouseRegion(
//                       cursor: SystemMouseCursors.click,
//                       child: const Text(
//                         "Privacy Policy",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.blue,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   LayoutBuilder(
//                     builder: (context, constraints) {
//                       return Wrap(
//                         spacing: 20,
//                         runSpacing: 20,
//                         alignment: WrapAlignment.center,
//                         children: const [
//                           DemoCard(
//                             role: "Admin",
//                             schoolid: "2",
//                             login: "demoadmin",
//                             password: "demo@123",
//                           ),
//                           DemoCard(
//                             role: "Staff",
//                             schoolid: "2",
//                             login: "9876543210",
//                             password: "demo@123",
//                           ),
//                           DemoCard(
//                             role: "Student",
//                             schoolid: "2",
//                             login: "2025000",
//                             password: "demo@123",
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// ✅ UNIFORM BUTTON BUILDER - SAME SIZE, REDUCED SHADOWS
//   Widget _buildUniformButton({
//     required VoidCallback onTap,
//     required IconData icon,
//     required Color color,
//     required String label,
//     Color? iconColor,
//     bool showClickCursor = true,
//   }) {
//     return MouseRegion(
//       cursor: showClickCursor ? SystemMouseCursors.click : MouseCursor.defer,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: onTap,
//         child: Column(
//           children: [
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 color: color,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withValues(alpha: 0.05),
//                     blurRadius: 4,
//                     offset: const Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: Icon(
//                 icon,
//                 size: 40,
//                 color: iconColor ?? Colors.white,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               label,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//                 color: Colors.black87,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeroText(bool isWide) {
//     return Column(
//       crossAxisAlignment: isWide
//           ? CrossAxisAlignment.start
//           : CrossAxisAlignment.center,
//       children: [
//         const Icon(Icons.school, size: 80, color: Colors.blue),
//         const SizedBox(height: 20),
//         Text(
//           "Smart Solutions for Smarter Schools",
//           textAlign: isWide ? TextAlign.start : TextAlign.center,
//           style: TextStyle(
//             fontSize: isWide ? 42 : 28,
//             color: Colors.blue.shade700,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           "Attendance, Homework, Assignments and more –\nfor Admins, Staff and Students.",
//           textAlign: isWide ? TextAlign.start : TextAlign.center,
//           style: TextStyle(fontSize: isWide ? 20 : 16, color: Colors.black87),
//         ),
//         const SizedBox(height: 25),
//         ElevatedButton.icon(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blue,
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30),
//             ),
//             elevation: 4,
//           ),
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const FeaturesPage()),
//             );
//           },
//           icon: const Icon(Icons.explore, size: 20),
//           label: const Text(
//             "Explore Features",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHeroImage(bool isWide) {
//     final screenWidth = MediaQuery.sizeOf(context).width;
//     return Container(
//       height: screenWidth > 1024
//           ? MediaQuery.sizeOf(context).height * 0.45
//           : screenWidth > 600
//           ? MediaQuery.sizeOf(context).height * 0.43
//           : MediaQuery.sizeOf(context).height * 0.3,
//       width: double.infinity,
//       decoration: BoxDecoration(color: Colors.transparent),
//       child: AutoPlayVideo(),
//     );
//   }
// }
//
// class DemoCard extends StatelessWidget {
//   final String role;
//   final String login;
//   final String password;
//   final String schoolid;
//
//   const DemoCard({
//     super.key,
//     required this.role,
//     required this.login,
//     required this.password,
//     required this.schoolid,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 4,
//       margin: const EdgeInsets.all(10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Container(
//         width: 300,
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             Text(
//               role,
//               style: const TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blue,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),
//             Text(
//               "School ID: $schoolid",
//               style: TextStyle(fontSize: 16),
//               textAlign: TextAlign.left,
//             ),
//             const SizedBox(height: 5),
//             Text(
//               "User ID: $login",
//               style: const TextStyle(fontSize: 16),
//               textAlign: TextAlign.left,
//             ),
//             const SizedBox(height: 5),
//             Text(
//               "Password: $password",
//               style: const TextStyle(fontSize: 16),
//               textAlign: TextAlign.left,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
// class AutoPlayVideo extends StatefulWidget {
//   const AutoPlayVideo({super.key});
//
//   @override
//   State<AutoPlayVideo> createState() => _AutoPlayVideoState();
// }
//
// class _AutoPlayVideoState extends State<AutoPlayVideo> {
//   late VideoPlayerController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('assets/screenV.mp4')
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//         _controller.setLooping(true);
//       });
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: _controller.value.isInitialized
//           ? AspectRatio(
//         aspectRatio: _controller.value.aspectRatio,
//         child: VideoPlayer(_controller),
//       )
//           : CircularProgressIndicator(),
//     );
//   }
// }
