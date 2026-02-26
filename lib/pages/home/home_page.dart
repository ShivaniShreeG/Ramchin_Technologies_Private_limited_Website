import 'package:flutter/material.dart';
import 'widget/footer.dart';
import 'widget/core.dart';
import 'widget/hero.dart';
import 'widget/why.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  final int selectedIndex;
  final void Function(int) onTabSelected;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 300 && !_showScrollToTop) {
        setState(() => _showScrollToTop = true);
      } else if (_scrollController.offset <= 300 && _showScrollToTop) {
        setState(() => _showScrollToTop = false);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      floatingActionButton: _showScrollToTop
          ? FloatingActionButton(
        onPressed: _scrollToTop,
        backgroundColor: Colors.white,
        child: const Icon(Icons.keyboard_arrow_up,color: Colors.blueAccent,),
      )
          : null,

      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
                child: HeroSection(
                  onPrimaryTap: () => widget.onTabSelected(1), // Services
                  onSecondaryTap: () => widget.onTabSelected(6), // Contact
                ),
              ),
            ),
            const CoreServicesSection(),
            const WhyChooseRamchinSection(),
            const SizedBox(height: 50),
            Footer(),
          ],
        ),
      ),
    );
  }
}