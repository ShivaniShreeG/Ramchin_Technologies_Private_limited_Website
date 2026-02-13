import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ramchin_web/pages/product/features_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/windowsbutton.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _textAnimationController;
  late Animation<Offset> _textSlideAnimation;

  final String pdfPath = 'assets/ramchin_pharmacy_manual.pdf';

  Future<void> _openPdf() async {
    final url = '${Uri.base.origin}/$pdfPath';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      // ignore: avoid_print
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
        'https://play.google.com/store/apps/details?id=YOUR_PHARMACY_APP_PACKAGE';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _launchWindowsStore() {
    // ✅ REAL WINDOWS URL
    const url = 'https://www.microsoft.com/store/apps/9NBLGGH4Z9Q2';
    html.window.open(url, '_blank');
  }

  void _launchWebsite() {
    // ✅ WEBSITE URL - Replace with your actual lodge app website
    const url = 'https://pharmacymanagement.ramchintech.com';
    html.window.open(url, '_blank');
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
    const Color pharmacyColor = Color(0xFF8B5A35);
    final Color lightBackground = pharmacyColor.withOpacity(0.08);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Ramchin Pharmacy Management",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
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
                  final bool isWide = constraints.maxWidth > 800;
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
              color: lightBackground,
              padding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Explore Our Pharmacy App Live",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: pharmacyColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Login with demo accounts and explore Billing, Stock, Expiry, GST Reports and more.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Download Ramchin Pharmacy Management App.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: pharmacyColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: _openPdf,
                    icon:
                    const Icon(Icons.picture_as_pdf, color: Colors.white),
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
                      backgroundColor: pharmacyColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                      shadowColor: pharmacyColor.withOpacity(0.6),
                    ),
                  ),
                  const SizedBox(height: 20),

                  /// Android / iOS buttons (hand cursor + black text)
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
                      // ✅ WINDOWS BUTTON ADDED
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

            /// WHY TRUST SECTION
            Container(
              width: double.infinity,
              color: Colors.white,
              padding:
              const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Why Pharmacies Trust Us",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: pharmacyColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Wrap(
                    spacing: 30,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: const [
                      _TrustCard(
                        color: pharmacyColor,
                        icon: Icons.medication_liquid,
                        title: "Expiry Management",
                        description:
                        "Automatic alerts for near-expiry and expired medicines.",
                      ),
                      _TrustCard(
                        color: pharmacyColor,
                        icon: Icons.inventory_2_outlined,
                        title: "Stock Control",
                        description:
                        "Real time stock, batch tracking and purchase planning.",
                      ),
                      _TrustCard(
                        color: pharmacyColor,
                        icon: Icons.receipt_long,
                        title: "GST Billing",
                        description:
                        "GST-ready invoices, daily reports and accounts export.",
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

  /// HERO TEXT
  Widget _buildHeroText(bool isWide) {
    const Color pharmacyColor = Color(0xFF8B5A35);

    return Column(
      crossAxisAlignment:
      isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        const Icon(Icons.local_pharmacy, size: 80, color: pharmacyColor),
        const SizedBox(height: 20),
        Text(
          "Complete Pharmacy Management Solution",
          textAlign: isWide ? TextAlign.start : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 42 : 28,
            color: pharmacyColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "Billing, Stock, Expiry, GST and more – for Medical Shops and Chains.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        const SizedBox(height: 25),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: pharmacyColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 4,
            shadowColor: pharmacyColor.withOpacity(0.6),
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

  /// HERO IMAGE / VIDEO
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
      child: const _AutoPlayVideo(),
    );
  }
}

/// DEMO CARD
class _DemoCard extends StatelessWidget {
  final String role;
  final String login;
  final String password;
  final String storeId;

  const _DemoCard({
    super.key,
    required this.role,
    required this.login,
    required this.password,
    required this.storeId,
  });

  @override
  Widget build(BuildContext context) {
    const Color pharmacyColor = Color(0xFF8B5A35);

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
                color: pharmacyColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "Store ID: $storeId",
              style: const TextStyle(fontSize: 16),
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

/// APK DOWNLOAD BUTTON
class _ApkDownloadButton extends StatelessWidget {
  const _ApkDownloadButton({super.key});

  @override
  Widget build(BuildContext context) {
    const Color pharmacyColor = Color(0xFF8B5A35);

    return ElevatedButton(
      onPressed: () {
        const apkPath = 'assets/apk/ramchinpharmacy.apk';
        html.AnchorElement anchor = html.AnchorElement(href: apkPath)
          ..setAttribute('download', 'ramchin_pharmacy.apk')
          ..click();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: pharmacyColor,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
      ),
      child: const Text(
        "Download APK",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// AUTO PLAY VIDEO WITH FALLBACK
class _AutoPlayVideo extends StatefulWidget {
  const _AutoPlayVideo({super.key});

  @override
  State<_AutoPlayVideo> createState() => _AutoPlayVideoState();
}

class _AutoPlayVideoState extends State<_AutoPlayVideo> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/pharmacy_screen.mp4')
      ..initialize().then((_) {
        if (!mounted) return;
        setState(() {
          _initialized = true;
        });
        _controller
          ..setLooping(true)
          ..play();
      }).catchError((error) {
        // If initialization fails, mark error so we can show icon.
        if (!mounted) return;
        setState(() {
          _hasError = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color pharmacyColor = Color(0xFF8B5A35);

    if (_hasError) {
      // Hard error -> show icon
      return const Center(
        child: Icon(
          Icons.local_pharmacy,
          size: 120,
          color: pharmacyColor,
        ),
      );
    }

    if (!_initialized) {
      // Still loading -> also show icon instead of loader
      return const Center(
        child: Icon(
          Icons.local_pharmacy,
          size: 120,
          color: pharmacyColor,
        ),
      );
    }

    // Initialized successfully -> show video
    return Center(
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: VideoPlayer(_controller),
      ),
    );
  }
}

/// TRUST CARD
class _TrustCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _TrustCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              textAlign: TextAlign.center,
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