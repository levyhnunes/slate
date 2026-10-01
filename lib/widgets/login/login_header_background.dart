import 'package:flutter/material.dart';

import 'package:slate/theme/app_theme.dart';
import 'package:slate/widgets/login/curved_header_clipper.dart';

/// The black curved header. It starts covering the whole screen (so the
/// splash seems to drain into it) as [reveal] goes 0 → 1, and floods the
/// screen again as [flood] goes 0 → 1.
class LoginHeaderBackground extends StatelessWidget {
  const LoginHeaderBackground({
    super.key,
    required this.headerHeight,
    required this.reveal,
    required this.flood,
  });

  final double headerHeight;
  final Animation<double> reveal;
  final Animation<double> flood;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: Listenable.merge([reveal, flood]),
        builder: (context, _) => ClipPath(
          clipper: CurvedHeaderClipper(
            headerHeight: headerHeight,
            progress: reveal.value * (1 - flood.value),
          ),
          child: const ColoredBox(color: AppColors.black),
        ),
      ),
    );
  }
}
