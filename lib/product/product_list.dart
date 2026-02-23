import 'package:flutter/material.dart';
import 'apps/school_management.dart';
import 'apps/hall_management.dart';
import 'apps/hospital_management.dart';
import 'apps/lodge_management.dart';
import 'apps/grocery_management.dart';
import 'apps/pharmacy_management.dart';
import 'apps/money_managment.dart';
import 'widget/product_header.dart';
import 'models/app_data.dart';
import 'widget/product_grid.dart';

class ProductListPage extends StatefulWidget {
  final Function(int) onTabSelected;

  const ProductListPage({
    super.key,
    required this.onTabSelected,
  });

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {

  final List<AppData> apps = [
    AppData(
      title: "Smart School",
      description: "Empowering smarter education management.",
      icon: Image.network(
        "https://www.ramchintech.com/companyweb/Logo/Product/1771664396958-18768973.png",
        fit: BoxFit.cover,
      ),
      destinationPage: const SchoolPage(),
    ),
    AppData(
      title: "Hospital Management",
      description: "Streamlining healthcare operations with precision.",
      icon: Image.network(
        "https://www.ramchintech.com/companyweb/Logo/Product/1771664372297-779776174.png",
        fit: BoxFit.cover,
      ),
      destinationPage: const HospitalManagementPage(),
    ),
    AppData(
      title:"Pharmacy Management",
      description: "Effortless billing and inventory control.",
      icon: Image.network(
        "https://www.ramchintech.com/companyweb/Logo/Product/1771664389099-375206227.png",
        fit: BoxFit.cover,
      ),
      destinationPage: const  PharmacyManagementPage(),
    ),
    AppData(
      title: "Hall Management",
      description: "Simplifying event bookings and scheduling.",
      icon: Image.network(
        "https://www.ramchintech.com/companyweb/Logo/Product/1771664367727-577671008.png",
        fit: BoxFit.cover,
      ),
      destinationPage: const HallManagementPage(),
    ),
    AppData(
      title: "Lodge Management",
      description: "Smart room management made simple.",
      icon: Image.network(
        "https://www.ramchintech.com/companyweb/Logo/Product/1771664376692-302919420.png",
        fit: BoxFit.cover,
      ),
      destinationPage: const LodgeManagementPage(),
    ),
    AppData(
      title: "Fin Track ",
      description: "Control your finances with confidence.",
      icon: Image.network(
        "https://www.ramchintech.com/companyweb/Logo/Product/1771664382983-949109623.png",
        fit: BoxFit.cover,
      ),
      destinationPage: const MoneyManagementPage(),
    ),
    AppData(
      title: "Grocery Management",
      description: "Smarter retail operations every day.",
      icon: Image.network(
          "https://www.ramchintech.com/companyweb/Logo/Product/1771664363024-386084719.png",
        fit: BoxFit.cover,
      ),
      destinationPage: const GroceryManagementPage(),
    ),
  ];
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _appsSectionKey = GlobalKey();
  void _scrollToApps() {
    final context = _appsSectionKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child:SingleChildScrollView(
          controller: _scrollController,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 48,
            vertical: isMobile ? 24 : 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductHeaderSection(
                isMobile: isMobile,
                onScrollToApps: _scrollToApps,
                onRequestCustomization: () => widget.onTabSelected(7),
              ),

              const SizedBox(height: 40),
              Container(
                key: _appsSectionKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    featuredAppsTitle(),
                    const SizedBox(height: 20),
                    ProductGrid(apps: apps),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget featuredAppsTitle() {
    return Center(
        child: Column(
          children: [
            const Text(
              "Explore Our Products",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: 80,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
    );
  }
}