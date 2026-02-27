import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'widget/microsoft_button.dart';
import 'widget/header.dart';
import 'widget/footer.dart';
import 'widget/video_header.dart';
import 'widget/button.dart';
import 'package:video_player/video_player.dart';
import 'features/money.dart';

class MoneyManagementPage extends StatefulWidget {
  const MoneyManagementPage({super.key});

  @override
  State<MoneyManagementPage> createState() => _MoneyManagementPageState();
}

class _MoneyManagementPageState extends State<MoneyManagementPage>
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

          // ===== MAIN SCROLL VIEW =====
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                Header (
                  title: "Fin Track",
                  subtitle: "Manage your money, track expenses, income, budgets, and generate detailed reports — all in one place.",
                  startColor: Colors.teal.shade50,
                  logoPath:"https://www.ramchintech.com/companyweb/Logo/Product/1771664382983-949109623.png",
                  endColor: Colors.white,
                  // trailingWidget: const HeroVideo(
                  //   videoPath: 'assets/screenV.mp4',
                  // ),
                  brandColor: Color(0xFF008080),
                  titleColor: Color(0xFF008080),
                  subtitleColor: Colors.teal.shade800, // instead of blueGrey
                  actionButton: SizedBox(
                    height: 60,
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
                            shadowColor:Colors.teal,
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
                            "Download App",
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
                          _sectionTitle("Manage Your Finances Effortlessly"),

                          const SizedBox(height: 18),

                          SizedBox(
                            width: 650,
                            child: Text(
                              "Track your income and expenses, set budgets, and generate reports in real time from any device.",
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
                      _sectionTitle("Why Choose Fin Track?"),
                      const SizedBox(height: 50),
                      _featuresGrid(),
                    ],
                  ),
                ),
                Footer(
                  title: "Ready to take control of your finances?",
                  buttonText: "Get Started Today",
                  onPressed: () => _launch("https://fintrack.ramchintech.com"),
                  backgroundColor: Colors.teal,
                  cornercolor: Colors.teal.shade50,
                )
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
                  child: const Icon(Icons.keyboard_arrow_up, size: 28,color: Colors.teal,),
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
        "title": "Expense Tracking",
        "desc": "Record and categorize your daily expenses easily.",
        "icon": Icons.account_balance_wallet,
      },
      {
        "title": "Income Management",
        "desc": "Track multiple income sources and recurring payments.",
        "icon": Icons.attach_money,
      },
      {
        "title": "Budget Planner",
        "desc": "Set budgets for categories and stay on top of your spending.",
        "icon": Icons.pie_chart,
      },
      {
        "title": "Reports & Analytics",
        "desc": "Visualize your finances through charts and summaries.",
        "icon": Icons.bar_chart_rounded,
      },
      {
        "title": "Reminders & Notes",
        "desc": "Add notes or reminders for bills, subscriptions, or goals.",
        "icon": Icons.note_alt_rounded,
      },
      {
        "title": "Secure Access",
        "desc": "Protect your data with passcodes & cloud backup.",
        "icon": Icons.security_rounded,
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
                      color:Colors.teal.shade50,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(
                      feature["icon"] as IconData,
                      color:  Colors.teal,
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
            color: Colors.teal.shade100,
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
                icon: Image.network(
                  "https://www.ramchintech.com/companyweb/Icon/1772169948779-125916949.png",
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
                    "https://moneymanagement.ramchintech.com"
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
              color:  Colors.teal,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
