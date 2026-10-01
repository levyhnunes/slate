import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:slate/widgets/home/contactless_icon.dart';

/// Brushed-metal platinum card.
class BankCard extends StatelessWidget {
  const BankCard({super.key, required this.holder});

  final String holder;

  static const _ink = Color(0xFF1F1E1C);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.57,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: CustomPaint(
          painter: _BrushedMetalPainter(),
          child: Stack(
            children: [
              const Positioned(
                top: 22,
                right: 24,
                child: ContactlessIcon(color: _ink),
              ),
              Positioned(
                left: 24,
                bottom: 35,
                child: Text(
                  holder,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const Positioned(
                right: 22,
                bottom: 19,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'VISA',
                      style: TextStyle(
                        color: _ink,
                        fontSize: 36,
                        height: 1,
                        fontWeight: FontWeight.w800,
                        fontStyle: FontStyle.italic,
                        letterSpacing: -1.5,
                      ),
                    ),
                    Text(
                      'Platinum',
                      style: TextStyle(
                        color: Color(0xFF6A6863),
                        fontSize: 11,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BrushedMetalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFA3A19A),
            Color(0xFFAEACA5),
            Color(0xFF9F9C95),
            Color(0xFFB2B0A9),
            Color(0xFFA5A39B),
          ],
          stops: [0, 0.3, 0.55, 0.8, 1],
        ).createShader(rect),
    );

    // Fine horizontal streaks give the brushed look.
    final random = math.Random(7);
    final streak = Paint()..strokeWidth = 1;
    for (var y = 0.5; y < size.height; y += 1) {
      final start = random.nextDouble() * size.width;
      final length = size.width * (0.2 + random.nextDouble() * 0.6);
      final light = random.nextBool();
      streak.color = (light ? Colors.white : Colors.black).withValues(
        alpha: 0.008 + random.nextDouble() * 0.02,
      );
      canvas.drawLine(Offset(start, y), Offset(start + length, y), streak);
    }
  }

  @override
  bool shouldRepaint(_BrushedMetalPainter oldDelegate) => false;
}
