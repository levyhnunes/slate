import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

/// Clips the black login header: its bottom edge starts low on the left,
/// dips a little past a third of the width, then sweeps up to the right.
///
/// [headerHeight] is the lowest point of the resting curve. [progress] goes
/// from 0 (the shape covers the whole area, like the splash) to 1 (resting
/// curve): the same curve slides down and gets deeper as it covers the screen.
class CurvedHeaderClipper extends CustomClipper<Path> {
  const CurvedHeaderClipper({required this.headerHeight, this.progress = 1});

  final double headerHeight;
  final double progress;

  /// Height of the curve's right end, relative to its lowest point.
  static const _rightFraction = 0.29;

  /// How much deeper the curve is when it fully covers the screen.
  static const _coverStretch = 1.7;

  @override
  Path getClip(Size size) {
    final w = size.width;
    final stretch = lerpDouble(_coverStretch, 1, progress)!;
    // At progress 0 even the curve's highest point (its right end) sits
    // below the bottom edge.
    final coverShift =
        size.height - headerHeight * _rightFraction * _coverStretch + 1;
    final shift = lerpDouble(coverShift, 0, progress)!;
    double y(double fraction) => headerHeight * fraction * stretch + shift;

    return Path()
      ..moveTo(0, 0)
      ..lineTo(0, y(0.82))
      ..cubicTo(w * 0.12, y(0.94), w * 0.24, y(1), w * 0.36, y(1))
      ..cubicTo(w * 0.60, y(1), w * 0.85, y(0.62), w, y(_rightFraction))
      ..lineTo(w, 0)
      ..close();
  }

  @override
  bool shouldReclip(CurvedHeaderClipper oldClipper) =>
      oldClipper.progress != progress ||
      oldClipper.headerHeight != headerHeight;
}
