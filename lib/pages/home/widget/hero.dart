import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onPrimaryTap,
    required this.onSecondaryTap,
  });

  final VoidCallback onPrimaryTap;
  final VoidCallback onSecondaryTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Defaults (Desktop)
    double horizontalPadding = 40;
    double verticalPadding = 80;
    double headingSize = 44;
    double bodySize = 18;
    double buttonPaddingH = 32;
    double buttonPaddingV = 18;
    double buttonFontSize = 16;
    double imageHeightFactor = 0.45;
    bool isMobile = false;

    // Tablet
    if (width < 900) {
      horizontalPadding = 28;
      verticalPadding = 56;
      headingSize = 32;
      bodySize = 15;
      buttonPaddingH = 26;
      buttonPaddingV = 14;
      buttonFontSize = 14;
      imageHeightFactor = 0.38;
    }

    // Mobile
    if (width < 600) {
      horizontalPadding = 20;
      verticalPadding = 40;
      headingSize = 26;
      bodySize = 14;
      buttonPaddingH = 22;
      buttonPaddingV = 12;
      buttonFontSize = 13;
      imageHeightFactor = 0.30;
      isMobile = true;
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: NetworkImage("https://www.ramchintech.com/companyweb/Home_Page/Website_Header/1772100892670-518957536.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: isMobile
          ? Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _content(
          context,
          headingSize,
          bodySize,
          buttonPaddingH,
          buttonPaddingV,
          buttonFontSize,
        ),
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _content(
                context,
                headingSize,
                bodySize,
                buttonPaddingH,
                buttonPaddingV,
                buttonFontSize,
              ),
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 4,
            child: Container(
              height: height * imageHeightFactor,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _content(
      BuildContext context,
      double headingSize,
      double bodySize,
      double buttonPaddingH,
      double buttonPaddingV,
      double buttonFontSize,
      ) {
    return [
      Text(
        "Empowering Modern Businesses\nthrough Intelligent Technology Solutions.",
        style: TextStyle(
          fontSize: headingSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.2,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        "From ready-to-use applications to fully customized software solutions, "
            "we help businesses transform ideas into powerful digital experiences.",
        style: TextStyle(
          fontSize: bodySize,
          color: Colors.white70,
          height: 1.6,
        ),
      ),
      const SizedBox(height: 32),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: [
          ElevatedButton(
            onPressed: onPrimaryTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orangeAccent,
              padding: EdgeInsets.symmetric(
                horizontal: buttonPaddingH,
                vertical: buttonPaddingV,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Explore Our Solutions",
              style: TextStyle(
                fontSize: buttonFontSize,
                color: Colors.white,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: onSecondaryTap,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: buttonPaddingH,
                vertical: buttonPaddingV,
              ),
              side: const BorderSide(color: Colors.white),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              "Talk to an Expert",
              style: TextStyle(
                fontSize: buttonFontSize,
                color: Colors.white,
              ),
            ),

          ),
        ],
      ),
    ];
  }
}