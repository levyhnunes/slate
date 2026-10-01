import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Multicolor Google "G" drawn with arcs, so no image asset is needed.
class GoogleLogo extends StatelessWidget {
  const GoogleLogo({super.key, this.size = 26});

  final double size;

  @override
  Widget build(BuildContext context) =>
      CustomPaint(size: Size.square(size), painter: _GoogleLogoPainter());
}

class _GoogleLogoPainter extends CustomPainter {
  static const _blue = Color(0xFF4285F4);
  static const _green = Color(0xFF34A853);
  static const _yellow = Color(0xFFFBBC05);
  static const _red = Color(0xFFEA4335);

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = size.width * 0.2;
    final rect = Rect.fromLTWH(
      stroke / 2,
      stroke / 2,
      size.width - stroke,
      size.height - stroke,
    );
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    double rad(double deg) => deg * math.pi / 180;

    // Angles in degrees, clockwise from 3 o'clock.
    canvas.drawArc(rect, rad(-40), rad(-90), false, paint..color = _red);
    canvas.drawArc(rect, rad(-130), rad(-80), false, paint..color = _yellow);
    canvas.drawArc(rect, rad(150), rad(-115), false, paint..color = _green);
    canvas.drawArc(rect, rad(35), rad(-35), false, paint..color = _blue);

    // Horizontal bar of the G.
    canvas.drawRect(
      Rect.fromLTWH(
        size.width / 2,
        size.height / 2 - stroke / 2,
        size.width / 2,
        stroke,
      ),
      Paint()..color = _blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
