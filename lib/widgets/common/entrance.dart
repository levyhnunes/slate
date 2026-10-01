import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Fades [child] in while moving it from [offset] to its resting place,
/// during the [begin]..[end] slice of [animation].
class Entrance extends StatelessWidget {
  const Entrance({
    super.key,
    required this.animation,
    required this.begin,
    required this.end,
    this.offset = const Offset(0, 28),
    this.beginScale = 1,
    required this.child,
  });

  /// Same as the default constructor, with the slice given in milliseconds
  /// of [controller]'s timeline: it starts at [startMs] and lasts [ms].
  factory Entrance.timed({
    Key? key,
    required AnimationController controller,
    required int startMs,
    int ms = 450,
    Offset offset = const Offset(0, 28),
    double beginScale = 1,
    required Widget child,
  }) {
    final total = controller.duration!.inMilliseconds;
    return Entrance(
      key: key,
      animation: controller,
      begin: startMs / total,
      end: math.min(1, (startMs + ms) / total),
      offset: offset,
      beginScale: beginScale,
      child: child,
    );
  }

  final Animation<double> animation;
  final double begin;
  final double end;
  final Offset offset;
  final double beginScale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fade = Interval(begin, end, curve: Curves.easeOut);
    final move = Interval(begin, end, curve: Curves.easeOutCubic);

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final rest = 1 - move.transform(animation.value);
        return Opacity(
          opacity: fade.transform(animation.value),
          child: Transform.translate(
            offset: offset * rest,
            child: Transform.scale(
              scale: 1 - (1 - beginScale) * rest,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
