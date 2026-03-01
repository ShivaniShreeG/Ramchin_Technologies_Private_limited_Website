import 'package:flutter/material.dart';
import '../old/course/pages/home_page.dart';
import 'home/home_page.dart';
import 'product/product_list.dart';
import 'about/about_page.dart';
import 'contact/contact_us.dart';
import 'gallery/gallery.dart';
import '../widgets/stacks/project_page_stack.dart';

class Page extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onTabSelected;

  const Page({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  int _currentIndex = 0;

  @override
  void didUpdateWidget(covariant Page oldWidget) {
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
          HomePage(selectedIndex: widget.selectedIndex, onTabSelected: widget.onTabSelected,),
          ProductListPage(onTabSelected: widget.onTabSelected,),
          AboutUsPage(),
          ProjectPageStack(),
          InternHomePage(),
          RamchinTechPhotoGallery(),
          ContactPage(),
        ],
      ),
    );
  }
}
