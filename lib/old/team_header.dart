import 'package:flutter/material.dart';

class TeamHeader extends StatelessWidget {
  final bool isMobile;

  const TeamHeader({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isMobile ? 45 : 65,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          Text(
            "Meet Our Professionals",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 26 : 34,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: Color(0xFF1E293B),
            ),
          ),

          const SizedBox(height: 18),

          Container(
            width: 70,
            height: 4,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF2563EB),
                  Color(0xFF1E40AF),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ],
      ),
    );
  }
}
