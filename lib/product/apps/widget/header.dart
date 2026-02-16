import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget? actionButton;
  final Widget? trailingWidget;
  final bool showBackButton;
  final String? logoPath;
  final Color startColor;
  final Color endColor;

  const Header({
    super.key,
    required this.title,
    required this.subtitle,
    this.actionButton,
    this.trailingWidget,
    this.showBackButton = true,
    this.startColor = const Color(0xFFE3F2FD),
    this.endColor = Colors.white,
    this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return ClipPath(
      clipper: BottomCornersCurveClipper(),
      child: Container(
        width: double.infinity,
        color: startColor.withOpacity(0.9),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: isWide ? 80 : 60,
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: isWide
                      ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(child: _textSection(isWide)),
                      if (trailingWidget != null) ...[
                        const SizedBox(width: 50),
                        Expanded(child: trailingWidget!),
                      ],
                    ],
                  )
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (trailingWidget != null) trailingWidget!,
                      const SizedBox(height: 30),
                      _textSection(isWide),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textSection(bool isWide) {
    return Column(
      crossAxisAlignment:
      isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        if (logoPath != null)
          Image.asset(
            logoPath!,
            height: isWide ? 80 : 60,
          ),
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 52 : 36,
            fontWeight: FontWeight.w800,
            height: 1.1,
            color: const Color(0xFF1A237E),
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 20 : 16,
            height: 1.5,
            color: Colors.blueGrey.shade800,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (actionButton != null) ...[
          const SizedBox(height: 40),
          actionButton!,
        ],
      ],
    );
  }
}

/// ClipPath for bottom-left and bottom-right curved corners only
class BottomCornersCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const curveHeight = 50.0;

    final path = Path();
    path.moveTo(0, 0); // top-left
    path.lineTo(0, size.height - curveHeight); // bottom-left before curve

    // bottom-left curve
    path.quadraticBezierTo(0, size.height, curveHeight, size.height);

    // straight bottom line
    path.lineTo(size.width - curveHeight, size.height);

    // bottom-right curve
    path.quadraticBezierTo(size.width, size.height, size.width, size.height - curveHeight);

    path.lineTo(size.width, 0); // top-right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
