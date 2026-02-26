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
  final Color brandColor;
  final Color titleColor;
  final Color subtitleColor;

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
    required this.brandColor,
    required this.titleColor,
    required this.subtitleColor,
  });

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return ClipPath(
      clipper: BottomCornersCurveClipper(),
      child: Container(
        width: double.infinity,
        color: startColor.withValues(alpha: 0.9),
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
                      ?trailingWidget,
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
        Row(
          mainAxisAlignment:
          isWide ? MainAxisAlignment.start : MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logoPath != null?
              Padding(
                padding: const EdgeInsets.only(bottom: 18,top: 0,left: 0,right: 0),
                child: Image.network(
                  logoPath!,
                  height: isWide ? 70 : 55,

                ),
              ):Text(
              "R",
              style: TextStyle(
                fontSize: isWide ? 70 : 50,
                fontWeight: FontWeight.w800,
                height: 1.1,
                color: brandColor,
              ),
            ),


            Text(
              "amchin",
              style: TextStyle(
                fontSize: isWide ? 70 : 50,
                fontWeight: FontWeight.w800,
                height: 1.1,
                color: brandColor,
              ),
            ),
          ],
        ),
        Text(
          title,
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 65 : 40,
            fontWeight: FontWeight.w800,
            height: 1.1,
            color: brandColor,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontSize: isWide ? 20 : 16,
            height: 1.5,
            color: subtitleColor,
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
