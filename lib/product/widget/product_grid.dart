import 'package:flutter/material.dart';
import '../models/app_data.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<AppData> apps;

  const ProductGrid({
    super.key,
    required this.apps,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount = 3;
    if (width < 600) {
      crossAxisCount = 1;
    } else if (width < 1000) {
      crossAxisCount = 2;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: apps.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.1,
      ),
      itemBuilder: (context, index) {
        return ProductCard(app: apps[index]);
      },
    );
  }
}
