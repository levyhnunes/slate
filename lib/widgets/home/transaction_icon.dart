import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:slate/models/transaction.dart';
import 'package:slate/theme/app_theme.dart';

/// Outlined circle with the glyph for a transaction [kind].
class TransactionIcon extends StatelessWidget {
  const TransactionIcon({super.key, required this.kind});

  final TransactionKind kind;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.hairline),
      ),
      child: kind == TransactionKind.conversion
          ? const Icon(
              Iconsax.arrow_swap_horizontal_copy,
              size: 17,
              color: AppColors.textPrimary,
            )
          : CustomPaint(painter: _GlyphPainter(kind)),
    );
  }
}

/// Hairline "↗" (transfer) and "+" (top up) glyphs.
class _GlyphPainter extends CustomPainter {
  const _GlyphPainter(this.kind);

  final TransactionKind kind;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final c = size.center(Offset.zero);

    if (kind == TransactionKind.topUp) {
      canvas
        ..drawLine(c - const Offset(5.5, 0), c + const Offset(5.5, 0), paint)
        ..drawLine(c - const Offset(0, 5.5), c + const Offset(0, 5.5), paint);
      return;
    }

    const r = 5.0;
    canvas
      ..drawLine(c + const Offset(-r, r), c + const Offset(r, -r), paint)
      ..drawPath(
        Path()
          ..moveTo(c.dx - r + 2.5, c.dy - r)
          ..lineTo(c.dx + r, c.dy - r)
          ..lineTo(c.dx + r, c.dy + r - 2.5),
        paint,
      );
  }

  @override
  bool shouldRepaint(_GlyphPainter oldDelegate) => oldDelegate.kind != kind;
}
