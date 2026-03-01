import 'package:flutter/material.dart';

class StoreButton extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;

  const StoreButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: Center(child: icon),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class PreButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool primary;
  final IconData? icon;

  const PreButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.primary = true,
    this.icon,
  });

  @override
  State<PreButton> createState() => _PremiumButtonState();
}

class _PremiumButtonState extends State<PreButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final scale = _hovering ? 1.05 : 1.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      transform: Matrix4.identity()
        ..scaleByDouble(scale, scale, scale, 1.0),        decoration: widget.primary
            ? BoxDecoration(
          gradient: LinearGradient(
            colors: _hovering
                ? [Colors.blue.shade600, Colors.blue.shade900]
                : [Colors.blue.shade500, Colors.blue.shade800],
          ),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withValues(alpha:0.4),
              blurRadius: _hovering ? 25 : 15,
              offset: const Offset(0, 8),
            )
          ],
        )
            : BoxDecoration(
          color: _hovering ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.blue.shade700, width: 2),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(40),
            onTap: widget.onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32, vertical: 18),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon,
                        color: widget.primary
                            ? Colors.white
                            : Colors.blue.shade800,
                        size: 18),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: widget.primary
                          ? Colors.white
                          : Colors.blue.shade800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

