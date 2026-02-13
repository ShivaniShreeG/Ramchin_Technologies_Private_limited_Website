import 'package:flutter/material.dart';
import 'header_feature.dart';

class ProductHeaderSection extends StatelessWidget {
  final bool isMobile;
  final VoidCallback onScrollToApps;
  final VoidCallback onRequestCustomization;

  const ProductHeaderSection({
    super.key,
    required this.isMobile,
    required this.onScrollToApps,
    required this.onRequestCustomization,
  });

  @override
  Widget build(BuildContext context) {
    final isMobiles = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 36,
        vertical: isMobile ? 32 : 48,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1F2937), Color(0xFF111827)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.redAccent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "RAMCHIN PRODUCTS",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            "Custom Software\nBuilt by Industry Experts",
            style: TextStyle(
              fontSize: isMobile ? 28 : 42,
              fontWeight: FontWeight.bold,
              height: 1.15,
              letterSpacing: -1,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 16),

          if (!isMobiles)
            const Text(
              "Ramchin designs and delivers fully customizable software solutions tailored to your industry. Backed by domain experts, we help businesses streamline operations, reduce costs, and scale with confidence.",
              style: TextStyle(
                fontSize: 17,
                height: 1.5,
                color: Colors.white70,
              ),
            ),

          const SizedBox(height: 28),

          const Column(
            children: [
              HeaderFeature(
                icon: Icons.tune,
                text: "Fully customizable solutions designed around your workflows",
              ),
              SizedBox(height: 12),
              HeaderFeature(
                icon: Icons.groups,
                text: "Built with experienced industry professionals",
              ),
              SizedBox(height: 12),
              HeaderFeature(
                icon: Icons.auto_graph,
                text: "Scalable architecture for growing businesses",
              ),
              SizedBox(height: 12),
              HeaderFeature(
                icon: Icons.support_agent,
                text: "Dedicated support & long-term enhancements",
              ),
            ],
          ),

          const SizedBox(height: 32),

          Wrap(
            spacing: 16,
            runSpacing: 12,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onScrollToApps,
                child: const Text(
                  "View Our Solutions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white54),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onRequestCustomization,
                child: const Text(
                  "Request Customization",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

