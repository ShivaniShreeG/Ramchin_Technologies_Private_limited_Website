import 'package:flutter/material.dart';
import 'dart:async';

class InternshipHeader extends StatelessWidget {
  const InternshipHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
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
                      ).createShader(
                        const Rect.fromLTWH(0, 0, 200, 70),
                      ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 260,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFEC4899), Color(0xFF4F46E5)],
              ),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "Discover the innovative digital solutions crafted by our talented team. "
                "Each project is designed with cutting-edge technology and user experience in mind.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black54, height: 1.4),
          ),
          SizedBox(height: 6),
          VisionCarousel(),
        ],
      ),
    );
  }
}


class VisionCarousel extends StatefulWidget {
  const VisionCarousel({super.key});

  @override
  State<VisionCarousel> createState() => _VisionCarouselState();
}

class _VisionCarouselState extends State<VisionCarousel> {
  final PageController _controller = PageController();
  int _currentIndex = 0;
  Timer? _timer;
  bool _showOverlay = true;

  late final List<Map<String, String>> _items;

  @override
  void initState() {
    super.initState();

    _items =
    [
      {
        "title": "E-Commerce Solutions",
        "desc":
        "Custom online stores designed for performance, security, and conversion.",
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
        "image":"https://www.ramchintech.com/companyweb/Gallery/1772518076092-166858587.jpeg"
      },
      {
        "title": "Enterprise Software",
        "desc":
        "Comprehensive solutions for large-scale business operations.",
        "image":"https://www.ramchintech.com/companyweb/Gallery/1772517001500-207167263.jpeg",
      },
    ];

    // Precache first two images for smoother start
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(NetworkImage(_items[0]["image"]!), context);
      if (_items.length > 1) {
        precacheImage(NetworkImage(_items[1]["image"]!), context);
      }
    });

    _startAutoPlay();
  }

  void _startAutoPlay() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 7), (_) {
      final nextIndex = (_currentIndex + 1) % _items.length;
      if (_controller.hasClients) {
        _controller.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _cacheAdjacentImages() {
    if (_currentIndex < _items.length - 1) {
      precacheImage(NetworkImage(_items[_currentIndex + 1]["image"]!), context);
    }
    if (_currentIndex > 0) {
      precacheImage(NetworkImage(_items[_currentIndex - 1]["image"]!), context);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Widget buildBackground(String imagePath) {
    return RepaintBoundary(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          imagePath,
          fit: BoxFit.cover,
          gaplessPlayback: true, // avoids flicker when images change
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.sizeOf(context).width < 600;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: isMobile ? 400 : 500,
        child: PageView.builder(
          controller: _controller,
          itemCount: _items.length,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
            _cacheAdjacentImages();
          },
          itemBuilder: (context, index) {
            final item = _items[index];
            return GestureDetector(
              onTap: () => setState(() => _showOverlay = !_showOverlay),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image
                  buildBackground(item["image"]!),

                  // Dark overlay
                  AnimatedOpacity(
                    opacity: _showOverlay ? 1 : 0,
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  // Text overlay (separated widget for fewer rebuilds)
                  OverlayContent(
                    showOverlay: _showOverlay,
                    title: item["title"]!,
                    desc: item["desc"]!,
                    isMobile: isMobile,
                  ),
                ],
              ),
            );
          },
        ),
      ),
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
