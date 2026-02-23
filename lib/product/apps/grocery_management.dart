import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'widget/microsoft_button.dart';
import 'widget/header.dart';
import 'widget/footer.dart';
import 'widget/video_header.dart';
import 'widget/button.dart';
import 'package:video_player/video_player.dart';
import 'features/grocery.dart';

class GroceryManagementPage extends StatefulWidget {
  const GroceryManagementPage({super.key});

  @override
  State<GroceryManagementPage> createState() => _GroceryManagementPageState();
}

class _GroceryManagementPageState extends State<GroceryManagementPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _demoSectionKey = GlobalKey();
  final String pdfPath = 'assets/ramchin_smart_school_manual.pdf';
  late VideoPlayerController _videoController;
  bool _isVideoReady = false;
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/screenV.mp4')
      ..initialize().then((_) {
        setState(() {
          _isVideoReady = true;
        });
        _videoController.play();
        _videoController.setLooping(true);
      });
    _scrollController.addListener(_scrollListener);

  }

  @override
  void dispose() {
    _controller.dispose();
    _videoController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 300 && !_showScrollToTop) {
      setState(() {
        _showScrollToTop = true;
      });
    } else if (_scrollController.offset <= 300 && _showScrollToTop) {
      setState(() {
        _showScrollToTop = false;
      });
    }
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToDemo() {
    final context = _demoSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (!_isVideoReady) {
    //   return const Scaffold(
    //     body: Center(child: CircularProgressIndicator()),
    //   );
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Header (
                  title: " Grocery Management",
                  subtitle:"Manage stock, sales, orders, and customer deliveries seamlessly — everything your grocery store needs in one smart platform.",
                  startColor: Colors.teal.shade50,
                  logoPath:"https://www.ramchintech.com/companyweb/Logo/Product/1771664363024-386084719.png",
                  endColor: Colors.white,
                  // trailingWidget: const HeroVideo(
                  //   videoPath: 'assets/screenV.mp4',
                  // ),
                  brandColor: Colors.teal,
                  titleColor: Colors.teal,
                  subtitleColor: Colors.teal.shade800,
                  actionButton: SizedBox(
                    height: 60, // fixed height
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            elevation: 5,
                            shadowColor: Colors.teal.shade200,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FeaturesPage(),
                              ),
                            );
                          },
                          child: const Text("Explore Features"),
                        ),
                        const SizedBox(width: 16),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: Colors.teal, width: 2),
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ).copyWith(
                            overlayColor: WidgetStateProperty.all(Colors.teal.shade50),
                          ),
                          onPressed: _scrollToDemo,
                          child: Text(
                            "Get the App",
                            style: TextStyle(color:Colors.teal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Container(
                  key: _demoSectionKey,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1150),
                      child: Column(
                        children: [
                          _sectionTitle("Explore Our Grocery Dashboard"),

                          const SizedBox(height: 18),

                          SizedBox(
                            width: 650,
                            child: Text(
                              "Manage real-time inventory, process customer orders, track sales, and optimize your grocery store operations efficiently from any device.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey.shade700,
                                height: 1.6,
                              ),
                            ),
                          ),

                          const SizedBox(height: 60),

                          _downloadCard(),

                          const SizedBox(height: 40),
                         ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 80),
                  decoration: BoxDecoration(
                    color:Colors.teal.shade50,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Column(
                    children: [
                      _sectionTitle("Why Grocery Choose Us?"),
                      const SizedBox(height: 50),
                      _featuresGrid(),
                    ],
                  ),
                ),
                Footer(
                  title: "Ready to Transform Your Grocery?",
                  buttonText: "Get Started Today",
                  onPressed: () =>
                      _launch("https://grocerymanagement.ramchintech.com"),
                  backgroundColor: Colors.teal,
                  cornercolor:Colors.teal.shade50,
                ),
              ],
            ),
          ),

          // ===== BACK BUTTON =====
          Positioned(
            top: 40,
            left: 20,
            child: _backButton(context),
          ),

          // ===== SCROLL TO TOP BUTTON =====
          if (_showScrollToTop)
            Positioned(
              bottom: 40,
              right: 30,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _showScrollToTop ? 1 : 0,
                child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  elevation: 6,
                  onPressed: _scrollToTop,
                  child: const Icon(Icons.keyboard_arrow_up, size: 28,color: Colors.teal),
                ),
              ),
            ),
        ],
      ),
    );
  }
  Widget _backButton(BuildContext context) {
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
              color: Colors.white.withValues(alpha: 0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.arrow_back_ios_new, color: Colors.teal, size: 20),
          ),
        ),
      ),
    );
  }


  Widget _featuresGrid() {
    final features = [
      {
        "title": "Inventory Control",
        "desc": "Manage grocery stock, categories, and suppliers easily.",
        "icon": Icons.inventory_2,
      },
      {
        "title": "Order Management",
        "desc": "Track customer orders, deliveries, and returns in real-time.",
        "icon": Icons.shopping_cart,
      },
      {
        "title": "Billing & POS",
        "desc": "Process sales quickly with integrated POS and invoicing.",
        "icon": Icons.point_of_sale,
      },
      {
        "title": "Analytics & Reports",
        "desc": "Get insights into sales trends, stock levels, and revenue.",
        "icon": Icons.bar_chart,
      },
      {
        "title": "Secure Access",
        "desc": "Protect store data and manage staff access safely.",
        "icon": Icons.security,
      },
      {
        "title": "24/7 Support",
        "desc": "Technical assistance whenever you need it.",
        "icon": Icons.support_agent,
      },
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Wrap(
        spacing: 30,
        runSpacing: 30,
        alignment: WrapAlignment.center,
        children: features.map((feature) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 300,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.grey.shade200,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Softer Icon Style
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      feature["icon"] as IconData,
                      color: Colors.teal,
                      size: 30,
                    ),
                  ),

                  const SizedBox(height: 22),

                  Text(
                    feature["title"] as String,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    feature["desc"] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Colors.grey.shade600,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _downloadCard() {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 30,
            offset: const Offset(0, 15),
          )
        ],
      ),
      child: Column(
        children: [
          const Text(
            "Download & Explore",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Wrap(
            spacing: 40,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [

              StoreButton(
                icon: Image.asset(
                  "assets/product/icon/playstore.png",
                  width: 55,
                  height: 55,
                ),
                label: "Google Play",
                onTap: () => _launch(
                  "https://play.google.com/store/apps/details?id=com.demo.ramchin_smart_school",
                ),
              ),

              StoreButton(
                icon: const Icon(Icons.android,
                    size: 55, color: Colors.green),
                label: "Download APK",
                onTap: () => _launch(
                  "https://yourdomain.com/downloads/app-release.apk",
                ),
              ),
              // StoreButton(
              //   icon: const WindowsLogo(),
              //   label: "Microsoft Store",
              //   onTap: () => _launch(
              //     "https://yourdomain.com/downloads/windows_app.zip",
              //   ),
              // ),
              // StoreButton(
              //   icon: const Icon(Icons.apple,
              //       size: 55, color: Colors.black),
              //   label: "iOS",
              //   onTap: () => _launch(
              //     "https://apps.apple.com/app/idYOUR_APP_ID",
              //   ),
              // ),

              StoreButton(
                icon: const Icon(Icons.window,
                    size: 55, color: Colors.blue),
                label: "Windows",
                onTap: () => _launch(
                  "https://yourdomain.com/downloads/windows_app.zip",
                ),
              ),



              StoreButton(
                icon: const Icon(Icons.language,
                    size: 55, color: Colors.deepPurple),
                label: "Website",
                onTap: () => _launch(
                  "https://grocerymanagement.ramchintech.com",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              height: 1.2,
              color: Color(0xFF1A1A1A),
            ),
          ),

          const SizedBox(height: 14),

          // Center underline
          Container(
            width: 70,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}

class DemoCard extends StatelessWidget {
  final String role;
  final String login;
  final String password;
  final String pharmacyid;

  const DemoCard({
    super.key,
    required this.role,
    required this.login,
    required this.password,
    required this.pharmacyid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color:Color(0xFF671A1A).withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 25,
            offset: const Offset(0, 12),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child:Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Color(0xFF671A1A).withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                role,
                style: TextStyle(
                  color: Color(0xFF671A1A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _infoTile("Pharmacy ID", pharmacyid),
          const SizedBox(height: 12),
          _infoTile("User ID", login),
          const SizedBox(height: 12),
          _infoTile("Password", password),
        ],
      ),
    );
  }

  Widget _infoTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Color(0xFF671A1A).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: "$label\n",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                  TextSpan(
                    text: value,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.copy, size: 18, color: Colors.grey.shade600),
            onPressed: () =>
                Clipboard.setData(ClipboardData(text: value)),
          )
        ],
      ),
    );
  }
}
