import 'package:flutter/material.dart' hide Page;
import 'appbar/mobile_appbar.dart';
import 'pages/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  void _onTabSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.sizeOf(context).width, 70),
        child: ResponsiveAppBar(
          selectedIndex: selectedIndex,
          onTabSelected: _onTabSelected,
        ),
      ),
      body: Page(
        selectedIndex: selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
