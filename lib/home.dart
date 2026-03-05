import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';
import 'pages/product/product_list.dart';
import 'pages/about/about_page.dart';
import 'pages/internship/internship.dart';
import 'pages/contact/contact_us.dart';
import 'pages/gallery/gallery.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  int selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ResponsiveAppBar(
        selectedIndex: selectedIndex,
        onTabSelected: _onTabSelected,
      ),
      body: Navigation(
        selectedIndex: selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int selectedIndex;
  final void Function(int) onTabSelected;

  const ResponsiveAppBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  // This tells the Scaffold how tall your custom bar is
  @override
  Size get preferredSize => const Size.fromHeight(80);

  final List<String> _tabs = const [
    "Home", "Products", "About Us", "Internship", "Gallery", "Contact Us"
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      // Same styling as before...
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SafeArea(
        child: Row(
          children: [
            _buildLogo(width < 600 ? 140 : 180),
            const Spacer(),
            if (width >= 1024)
              _buildDesktopNav()
            else if (width >= 600)
              _buildTabletNav()
            else
              _buildMobileNav(context),
          ],
        ),
      ),
    );
  }
  PopupMenuItem<int> _buildStyledMenuItem(int value, String title, IconData icon) {
    return PopupMenuItem<int>(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.blue.shade700),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    return PopupMenuButton<int>(
      color: Colors.white,
      offset: const Offset(0, 60),
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.withValues(alpha:0.1)),
      ),
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha:0.05),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Icon(Icons.menu_rounded, color: Colors.blue, size: 26),
      ),
      onSelected: onTabSelected,
      itemBuilder: (context) => [
        _buildStyledMenuItem(0, "Home", Icons.home_outlined),
        _buildStyledMenuItem(1, "Products", Icons.inventory_2_outlined),
        _buildStyledMenuItem(2, "About Us", Icons.business_outlined),
        _buildStyledMenuItem(3, "Internship", Icons.school_outlined),
        _buildStyledMenuItem(4, "Gallery", Icons.collections_outlined),
        _buildStyledMenuItem(5, "Contact Us", Icons.alternate_email_outlined),
      ],
    );
  }

  Widget _navItem(String title, int index) {
    bool isSelected = selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: () => onTabSelected(index),
        borderRadius: BorderRadius.circular(8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.withValues(alpha:0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.blue.shade800 : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_tabs.length, (i) => _navItem(_tabs[i], i)),
    );
  }

  Widget _buildTabletNav() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _navItem("Home", 0),
        _navItem("Products", 1),
        _navItem("About", 2),
        const SizedBox(width: 8),
        // The "More" menu styled exactly like the mobile version
        PopupMenuButton<int>(
          tooltip: "Show More",
          color: Colors.white,
          surfaceTintColor: Colors.white,
          offset: const Offset(0, 50),
          elevation: 10,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.grey.shade100),
          ),
          onSelected: onTabSelected,
          itemBuilder: (context) => [
            _buildStyledMenuItem(3, "Internship", Icons.school_outlined),
            _buildStyledMenuItem(4, "Gallery", Icons.collections_outlined),
            _buildStyledMenuItem(5, "Contact Us", Icons.alternate_email_outlined),
          ],
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha:0.05),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.menu_rounded, color: Colors.blue),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget _buildLogo(double width) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => onTabSelected(0),
        child: Image.network(
          "https://www.ramchintech.com/companyweb/Logo/Company/1771658553998-120044895.png",
          width: width,
          height: 50,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class Navigation extends StatefulWidget {
  final int selectedIndex;
  final void Function(int) onTabSelected;

  const Navigation({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  late Widget _currentPage;

  @override
  void initState() {
    super.initState();

    _currentPage = _buildPage(widget.selectedIndex);
  }

  @override
  void didUpdateWidget(covariant Navigation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedIndex != oldWidget.selectedIndex) {
      FocusScope.of(context).unfocus();

      _currentPage = _buildPage(widget.selectedIndex);

      setState(() {});
    }
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomePage(
          selectedIndex: widget.selectedIndex,
          onTabSelected: widget.onTabSelected,
        );
      case 1:
        return ProductListPage(
          onTabSelected: widget.onTabSelected,
        );
      case 2:
        return const AboutUsPage();
      case 3:
        return InternshipPage(
          onTabSelected: widget.onTabSelected,
        );
      case 4:
        return const GalleryPage();
      case 5:
        return const ContactPage();
      default:
        return  HomePage(
          selectedIndex: widget.selectedIndex,
          onTabSelected: widget.onTabSelected,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _currentPage;
  }
}