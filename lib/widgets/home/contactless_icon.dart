import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Contactless payment symbol: three arcs fanning out to the upper right.
class ContactlessIcon extends StatelessWidget {
  const ContactlessIcon({super.key, required this.color, this.size = 36});

  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: _ContactlessPainter(color),
    );
  }
}

class _ContactlessPainter extends CustomPainter {
  const _ContactlessPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.064
      ..strokeCap = StrokeCap.round;
    final origin = Offset(0, size.height);
    for (final fraction in [0.42, 0.69, 0.97]) {
      canvas.drawArc(
        Rect.fromCircle(center: origin, radius: size.width * fraction),
        -math.pi / 2 + 0.15,
        math.pi / 2 - 0.2,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_ContactlessPainter oldDelegate) =>
      oldDelegate.color != color;
}
