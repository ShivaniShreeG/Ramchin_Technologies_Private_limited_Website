import 'package:flutter/material.dart';

class WindowsDownloadButton extends StatefulWidget {
  final VoidCallback onTap;

  const WindowsDownloadButton({
    super.key,
    required this.onTap,
  });

  @override
  State<WindowsDownloadButton> createState() => _WindowsDownloadButtonState();
}

class _WindowsDownloadButtonState extends State<WindowsDownloadButton> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // ✅ CLICK CURSOR
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          children: [
            Container(
              width: 79,
              height: 79,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: WindowsLogo(),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Windows",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
  static const Color _cyan = Color(0xFFE45E0A);    // Top-left
  static const Color _green = Color(0xFF00D40B);   // Top-right
  static const Color _purple = Color(0xFF009BD4);  // Bottom-left
  static const Color _gold = Color(0xFFFDB300);    // Bottom-right

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final boxSize = size.width * 0.29; // ✅ INCREASED FROM 0.20 to 0.28 - LARGER BOXES

    // Cyan - Top-left (LARGER)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx * 0.68, center.dy * 0.68),
          width: boxSize,
          height: boxSize,
        ),
        const Radius.circular(1),
      ),
      Paint()..color = _cyan,
    );

    // Green - Top-right (LARGER)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx * 1.32, center.dy * 0.68),
          width: boxSize,
          height: boxSize,
        ),
        const Radius.circular(1),
      ),
      Paint()..color = _green,
    );

    // Purple - Bottom-left (LARGER)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx * 0.68, center.dy * 1.32),
          width: boxSize,
          height: boxSize,
        ),
        const Radius.circular(1),
      ),
      Paint()..color = _purple,
    );

    // Gold - Bottom-right (LARGER)
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(center.dx * 1.32, center.dy * 1.32),
          width: boxSize,
          height: boxSize,
        ),
        const Radius.circular(1),
      ),
      Paint()..color = _gold,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
