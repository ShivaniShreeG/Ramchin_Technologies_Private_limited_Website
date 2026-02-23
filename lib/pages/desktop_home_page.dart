import 'package:flutter/material.dart';
import 'package:ramchin_web/product/product_list.dart';
import '../intern/pages/homepage.dart';
import '../widgets/About.dart';
import '../team/team_page.dart';
import '../widgets/AddData.dart';
import '../widgets/Contact.dart';
import '../widgets/Gallery.dart';
import '../widgets/stacks/Admin_page_stack.dart';
import '../widgets/stacks/home_page_stack.dart';
import '../widgets/stacks/service_page_stack.dart';
import '../widgets/stacks/project_page_stack.dart';

class DesktopHomePage extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onTabSelected;

  const DesktopHomePage({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  int _currentIndex = 0;

  @override
  void didUpdateWidget(covariant DesktopHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedIndex != _currentIndex) {
      // ✅ Release focus when changing tab so keyboard doesn’t get stuck
      FocusScope.of(context).unfocus();
      setState(() {
        _currentIndex = widget.selectedIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomePageStack(selectedIndex: _currentIndex, onTabSelected: widget.onTabSelected,),
          ProductListPage(onTabSelected: widget.onTabSelected,),
          TeamPage(),
          ProjectPageStack(),
          ServicePageStack(onTabSelected: widget.onTabSelected),
          InternshipPage(),
          RamchinTechPhotoGallery(),
          ContactPage(),
          AboutUsPage(),
          AdminPageStack(onTabSelected: widget.onTabSelected),
          AddData(),
        ],
      ),
    );
  }
}
