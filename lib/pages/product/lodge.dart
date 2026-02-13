import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;
import '../../widgets/windowsbutton.dart';
import 'widgets/windowsbutton.dart'; // Add this import

class LodgeAppPage extends StatefulWidget {
  const LodgeAppPage({super.key});

  @override
  State<LodgeAppPage> createState() => LodgeAppPageState();
}

class LodgeAppPageState extends State<LodgeAppPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: Offset.zero,
    ).animate(
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

  void _openPdf() async {
    final String pdfPath = 'assets/lodgemanual.pdf';
    final url = Uri.base.resolve(pdfPath);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        Uri.parse('/$pdfPath'),
        mode: LaunchMode.externalApplication,
      );
    } else {
      print('Could not open PDF');
    }
  }

  void _launchPlayStore() {
    // ✅ REAL ANDROID URL
    const url = 'https://play.google.com/store/apps/details?id=com.ramchintech.lodge';
    html.window.open(url, '_blank');
  }

  void _launchAppStore() {
    // ✅ REAL iOS URL
    const url = 'https://apps.apple.com/us/app/ramchin-lodge-management/id1234567893';
    html.window.open(url, '_blank');
  }

  void _launchWindowsStore() {
    // ✅ REAL WINDOWS URL
    const url = 'https://www.microsoft.com/store/apps/9NBLGGH4Z9Q4';
    html.window.open(url, '_blank');
  }

  void _launchWebsite() {
    // ✅ WEBSITE URL - Replace with your actual lodge app website
    const url = 'https://lodgemanagement.ramchintech.com';
    html.window.open(url, '_blank');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Lodge Management"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HERO SECTION
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
            // DOWNLOAD SECTION - ✅ WINDOWS + WEBSITE BUTTONS FIXED
            Container(
              width: double.infinity,
              color: const Color(0xFF3F6F93).withOpacity(0.06),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Explore Our Lodge App Live",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F6F93),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Login with demo accounts and explore room booking, payments, and more.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Download the Lodge Management App.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F6F93),
                    ),
                  ),
                  const SizedBox(height: 20),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: ElevatedButton.icon(
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
                            horizontal: 15, vertical: 14),
                        backgroundColor: const Color(0xFF3F6F93),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 6,
                        shadowColor: const Color(0xFF3F6F93).withOpacity(0.5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // ✅ 4 BUTTONS: Android + iOS + Windows + Website
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _launchPlayStore,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.android,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Android",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _launchAppStore,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.apple,
                                    size: 40,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "iOS",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      // ✅ WINDOWS BUTTON
                      WindowsDownloadButton(
                        onTap: _launchWindowsStore,
                      ),
                      const SizedBox(width: 24),
                      // ✅ WEBSITE BUTTON - FIXED: White background, Black icon
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: _launchWebsite,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white, // ✅ WHITE BACKGROUND
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.12),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Icon(
                                    Icons.language,
                                    size: 39,
                                    color: Colors.black, // ✅ BLACK ICON
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                "Website",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // WHY TRUST US SECTION
            Container(
              color: Colors.white,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Why Guests Trust Our Lodge",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3F6F93),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Wrap(
                    spacing: 30,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      TrustCard(
                        icon: Icons.bed,
                        title: "Instant Room Booking",
                        description: "Real-time room availability & instant confirmations.",
                      ),
                      TrustCard(
                        icon: Icons.payments,
                        title: "Secure Payments",
                        description: "Multiple payment options with instant refunds.",
                      ),
                      TrustCard(
                        icon: Icons.support_agent,
                        title: "24/7 Support",
                        description: "Dedicated support team for your stay anytime.",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroText(bool isWide) {
    return Column(
      crossAxisAlignment: isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        const Icon(Icons.hotel, size: 80, color: Color(0xFF3F6F93)),
        const SizedBox(height: 20),
        Text(
          "Book Comfortable Rooms For Every Stay",
          textAlign: isWide ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 42 : 28,
            color: const Color(0xFF3F6F93),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "Business trips, vacations, family stays, and more.",
          textAlign: isWide ? TextAlign.start : TextAlign.center,
          style: TextStyle(fontSize: isWide ? 20 : 16, color: Colors.black87),
        ),
        const SizedBox(height: 25),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3F6F93),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              elevation: 4,
              shadowColor: const Color(0xFF3F6F93).withOpacity(0.5),
            ),
            onPressed: () {},
            icon: const Icon(Icons.explore, size: 20),
            label: const Text(
              "Explore Features",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
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
      decoration: const BoxDecoration(color: Colors.transparent),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/lodgedemo.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFF3F6F93).withOpacity(0.06),
            child: const Icon(
              Icons.hotel,
              size: 100,
              color: Color(0xFF3F6F93),
            ),
          ),
        ),
      ),
    );
  }
}

class TrustCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  const TrustCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 250,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 50, color: const Color(0xFF3F6F93)),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F6F93),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
