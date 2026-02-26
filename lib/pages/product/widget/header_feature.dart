import 'package:flutter/material.dart';

class HeaderFeature extends StatelessWidget {
  final IconData icon;
  final String text;

  const HeaderFeature({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.redAccent, size: 18),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
