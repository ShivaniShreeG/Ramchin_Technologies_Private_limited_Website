import 'package:flutter/material.dart';

class WindowsLogo extends StatelessWidget {
  const WindowsLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(50, 50),
      painter: WindowsLogoPainter(),
    );
  }
}

class WindowsLogoPainter extends CustomPainter {
  Color green = Color(0xFF00D40B);
  Color purple = Color(0xFF009BD4);
  Color gold = Color(0xFFFDB300);
  Color cyan = Color(0xFFE45E0A);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final boxSize = size.width * 0.29;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx * 0.68, center.dy * 0.68),
          width: boxSize,
          height: boxSize,
        ),
        const Radius.circular(1),
      ),
      Paint()..color = cyan,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx * 1.32, center.dy * 0.68),
          width: boxSize,
          height: boxSize,
        ),
        const Radius.circular(1),
      ),
      Paint()..color = green,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx * 0.68, center.dy * 1.32),
          width: boxSize,
          height: boxSize,
        ),
        const Radius.circular(1),
      ),
      Paint()..color = purple,
    );

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx * 1.32, center.dy * 1.32),
          width: boxSize,
          height: boxSize,
        ),
        const Radius.circular(1),
      ),
      Paint()..color = gold,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
