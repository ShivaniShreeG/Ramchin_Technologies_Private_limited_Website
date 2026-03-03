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

class ResponsiveAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final int selectedIndex;
  final void Function(int) onTabSelected;

  const ResponsiveAppBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  State<ResponsiveAppBar> createState() => _ResponsiveAppBarState();
}

class _ResponsiveAppBarState extends State<ResponsiveAppBar>
    with TickerProviderStateMixin {
  TabController? _tabletController;
  TabController? _desktopController;

  final List<String> _tabs = const [
    "Home",
    "Products",
    "About Us",
    "Internship",
    "Gallery",
    "Contact Us",
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initControllers();
  }

  void _initControllers() {
    final width = MediaQuery.of(context).size.width;

    if (width >= 600 && width < 1024) {
      _tabletController ??=
          TabController(length: 3, vsync: this);
    } else if (width >= 1024) {
      _desktopController ??=
          TabController(length: 6, vsync: this);
    }
  }

  @override
  void didUpdateWidget(covariant ResponsiveAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (_tabletController != null &&
        widget.selectedIndex < 3 &&
        _tabletController!.index != widget.selectedIndex) {
      _tabletController!.index = widget.selectedIndex;
    }

    if (_desktopController != null &&
        widget.selectedIndex < 6 &&
        _desktopController!.index != widget.selectedIndex) {
      _desktopController!.index = widget.selectedIndex;
    }
  }

  @override
  void dispose() {
    _tabletController?.dispose();
    _desktopController?.dispose();
    super.dispose();
  }

  void _goHome() {
    widget.onTabSelected(0);
  }

  Widget _buildLogo(double width) {
    return InkWell(
      onTap: _goHome,
      child: Image.network(
        "https://www.ramchintech.com/companyweb/Logo/Company/1771658553998-120044895.png",
        width: width,
        height: 70,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // ------------------ MOBILE ------------------
    if (width < 600) {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 4,
        automaticallyImplyLeading: false,
        leadingWidth: 200,
        leading: Padding(
          padding: const EdgeInsets.all(4),
          child: _buildLogo(180),
        ),
        actions: [
          PopupMenuButton<int>(
            onSelected: widget.onTabSelected,
            itemBuilder: (context) => List.generate(
              _tabs.length,
                  (i) => PopupMenuItem(
                value: i,
                child: Text(_tabs[i]),
              ),
            ),
            icon: const Icon(Icons.menu, color: Colors.black87),
          ),
        ],
      );
    }

    // ------------------ TABLET ------------------
    if (width < 1024) {
      return Container(
        height: 80,
        color: Colors.white,
        child: Row(
          children: [
            const SizedBox(width: 12),
            _buildLogo(180),
            const Spacer(),
            TabBar(
              controller: _tabletController,
              isScrollable: true,
              indicatorColor: Colors.blue,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black87,
              tabs: const [
                Tab(text: "Home"),
                Tab(text: "Products"),
                Tab(text: "About Us"),
              ],
              onTap: widget.onTabSelected,
            ),
            PopupMenuButton<int>(
              onSelected: widget.onTabSelected,
              itemBuilder: (context) => const [
                PopupMenuItem(value: 3, child: Text("Internship")),
                PopupMenuItem(value: 4, child: Text("Gallery")),
                PopupMenuItem(value: 5, child: Text("Contact Us")),
              ],
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Icon(Icons.more_vert, color: Colors.black87),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 80,
      color: Colors.white,
      child: Row(
        children: [
          const SizedBox(width: 16),
          _buildLogo(220),
          const Spacer(),
          TabBar(
            controller: _desktopController,
            isScrollable: true,
            indicatorColor: Colors.blue,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.black87,
            tabs: _tabs.map((t) => Tab(text: t)).toList(),
            onTap: widget.onTabSelected,
          ),
          const SizedBox(width: 16),
        ],
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
        return const InternshipPage();
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