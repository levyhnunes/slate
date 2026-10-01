import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Two-dot loader: a big dot in the middle and a small one that buds off to
/// the right, merges back, then buds off to the left, joined by a gooey
/// bridge while they are close. Animates only while [active].
class GooeyDotsLoader extends StatefulWidget {
  const GooeyDotsLoader({super.key, required this.active, required this.size});

  final bool active;
  final Size size;

  @override
  State<GooeyDotsLoader> createState() => _GooeyDotsLoaderState();
}

class _GooeyDotsLoaderState extends State<GooeyDotsLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  @override
  void initState() {
    super.initState();
    if (widget.active) _controller.repeat();
  }

  @override
  void didUpdateWidget(GooeyDotsLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active == oldWidget.active) return;
    if (widget.active) {
      _controller.repeat();
    } else {
      _controller
        ..stop()
        ..value = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: widget.size,
      painter: _GooeyDotsPainter(_controller),
    );
  }
}

class _GooeyDotsPainter extends CustomPainter {
  _GooeyDotsPainter(this.progress) : super(repaint: progress);

  final Animation<double> progress;

  static const _bigRadius = 11.5;
  static const _smallRadius = 6.5;
  static const _travel = 31.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = const Color(0xFFBDBDBD);
    final center = size.center(Offset.zero);
    final swing = math.sin(progress.value * 2 * math.pi);
    final small = center + Offset(_travel * swing, 0);
    // The big dot gives up a little volume while the small one is out.
    final bigRadius = _bigRadius - 1.5 * swing.abs();

    canvas.drawCircle(center, bigRadius, paint);
    canvas.drawCircle(small, _smallRadius, paint);
    final bridge = _bridge(center, bigRadius, small, _smallRadius);
    if (bridge != null) canvas.drawPath(bridge, paint);
  }

  /// Metaball-style connector between two circles, or null when they are
  /// too far apart (or one contains the other).
  Path? _bridge(Offset c1, double r1, Offset c2, double r2) {
    const spread = 0.5;
    const handleSize = 2.4;
    final d = (c2 - c1).distance;
    if (d > (r1 + r2) * 1.55 || d <= (r1 - r2).abs()) return null;

    var u1 = 0.0;
    var u2 = 0.0;
    if (d < r1 + r2) {
      u1 = math.acos((r1 * r1 + d * d - r2 * r2) / (2 * r1 * d));
      u2 = math.acos((r2 * r2 + d * d - r1 * r1) / (2 * r2 * d));
    }

    final between = (c2 - c1).direction;
    final maxSpread = math.acos((r1 - r2) / d);
    final a1 = between + u1 + (maxSpread - u1) * spread;
    final a2 = between - u1 - (maxSpread - u1) * spread;
    final a3 = between + math.pi - u2 - (math.pi - u2 - maxSpread) * spread;
    final a4 = between - math.pi + u2 + (math.pi - u2 - maxSpread) * spread;

    final p1 = c1 + Offset.fromDirection(a1, r1);
    final p2 = c1 + Offset.fromDirection(a2, r1);
    final p3 = c2 + Offset.fromDirection(a3, r2);
    final p4 = c2 + Offset.fromDirection(a4, r2);

    final total = r1 + r2;
    final handle =
        math.min(spread * handleSize, (p1 - p3).distance / total) *
        math.min(1, d * 2 / total);
    final h1 = p1 + Offset.fromDirection(a1 - math.pi / 2, r1 * handle);
    final h2 = p2 + Offset.fromDirection(a2 + math.pi / 2, r1 * handle);
    final h3 = p3 + Offset.fromDirection(a3 + math.pi / 2, r2 * handle);
    final h4 = p4 + Offset.fromDirection(a4 - math.pi / 2, r2 * handle);

    return Path()
      ..moveTo(p1.dx, p1.dy)
      ..cubicTo(h1.dx, h1.dy, h3.dx, h3.dy, p3.dx, p3.dy)
      ..lineTo(p4.dx, p4.dy)
      ..cubicTo(h4.dx, h4.dy, h2.dx, h2.dy, p2.dx, p2.dy)
      ..close();
  }

  @override
  bool shouldRepaint(_GooeyDotsPainter oldDelegate) => false;
}
