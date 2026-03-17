import 'package:flutter/material.dart';
import 'dart:async';

class InternshipHeader extends StatelessWidget {
  const InternshipHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bool isMobile = width < 600;

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: -50,
          right: isMobile ? -20 : width * 0.1,
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF4F46E5).withValues(alpha:0.08),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: isMobile ? 40 : 60
          ),
          child: Column(
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 800),
                tween: Tween(begin: 0.8, end: 1.0),
                builder: (context, value, child) => Transform.scale(
                  scale: value,
                  child: child,
                ),
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: isMobile ? 32 : 54,
                          height: 1.1,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1E293B),
                        ),
                        children: [
                          const TextSpan(text: "Our "),
                          TextSpan(
                            text: "Internship Projects",
                            style: TextStyle(
                              foreground: Paint()
                                ..shader = const LinearGradient(
                                  colors: [
                                    Color(0xFF4F46E5),
                                    Color(0xFF9333EA),
                                    Color(0xFFEC4899),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ).createShader(
                                  const Rect.fromLTWH(0, 0, 400, 100),
                                ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 4,
                      width: 80,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF4F46E5), Color(0xFFEC4899)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Text(
                  "Empowering the next generation of developers through hands-on experience "
                      "with real-world enterprise applications and innovative digital platforms.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 20,
                    color: Colors.grey.shade600,
                    height: 1.6,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const VisionCarousel(),
            ],
          ),
        ),
      ],
    );
  }
}

class VisionCarousel extends StatefulWidget {
  const VisionCarousel({super.key});

  @override
  State<VisionCarousel> createState() => _VisionCarouselState();
}

class _VisionCarouselState extends State<VisionCarousel> {
  late final PageController _controller;
  int _currentIndex = 0;
  Timer? _timer;

  final List<Map<String, String>> _items = [
    {
      "title": "E-Commerce Solutions",
      "desc": "Custom online stores designed for performance and conversion.",
      "image": "https://www.ramchintech.com/companyweb/Gallery/1772518089237-820830305.jpeg",
    },
    {
      "title": "Web Application",
      "desc": "Robust, scalable, and secure web applications.",
      "image": "https://www.ramchintech.com/companyweb/Gallery/1772518094408-218587385.jpeg",
    },
    {
      "title": "Mobile Solutions",
      "desc": "Cross-platform iOS and Android apps with seamless UX.",
      "image": "https://www.ramchintech.com/companyweb/Gallery/1772518098884-746405697.jpeg"
    },
    {
      "title": "Enterprise Software",
      "desc": "Comprehensive solutions for large-scale business operations.",
      "image": "https://www.ramchintech.com/companyweb/Gallery/1772517001500-207167263.jpeg",
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.85);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_controller.hasClients) {
        int nextIndex = (_currentIndex + 1) % _items.length;
        _controller.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Column(
      children: [
        SizedBox(
          height: isMobile ? 350 : 500,
          child: PageView.builder(
            controller: _controller,
            itemCount: _items.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              double scale = _currentIndex == index ? 1.0 : 0.9;

              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 350),
                tween: Tween(begin: scale, end: scale),
                builder: (context, double value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          _items[index]["image"]!,
                          fit: BoxFit.cover,
                        ),
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha:0.8),
                                ],
                                stops: const [0.6, 1.0],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _items[index]["title"]!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 22 : 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                _items[index]["desc"]!,
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha:0.9),
                                  fontSize: isMobile ? 14 : 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_items.length, (index) {
            bool isSelected = _currentIndex == index;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: isSelected ? 24 : 8,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF4F46E5) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class OverlayContent extends StatelessWidget {
  final bool showOverlay;
  final String title;
  final String desc;
  final bool isMobile;

  const OverlayContent({
    super.key,
    required this.showOverlay,
    required this.title,
    required this.desc,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: showOverlay ? 1 : 0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.3),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: Text(
                title,
                key: ValueKey("$title$showOverlay"),
                style: TextStyle(
                  fontSize: isMobile ? 24 : 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 700),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.4),
                    end: Offset.zero,
                  ).animate(anim),
                  child: child,
                ),
              ),
              child: ConstrainedBox(
                key: ValueKey("$desc$showOverlay"),
                constraints: BoxConstraints(
                  maxWidth:
                  MediaQuery.of(context).size.width / (isMobile ? 1 : 1.3),
                ),
                child: Text(
                  desc,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 18,
                    height: isMobile ? 1.6 : 1.8,
                    letterSpacing: 0.3,
                    wordSpacing: isMobile ? 1 : 1.5,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
