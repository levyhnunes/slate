import 'package:flutter/material.dart';

/// Rises [child] in during [enter], then slides it out to the right during
/// [exit]. Both are slices of [animation].
class SplashTextTransition extends StatelessWidget {
  const SplashTextTransition({
    super.key,
    required this.animation,
    required this.enter,
    required this.exit,
    required this.child,
  });

  final Animation<double> animation;
  final Interval enter;
  final Interval exit;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fadeIn = Interval(enter.begin, enter.end, curve: Curves.easeOut);
    final rise = Interval(enter.begin, enter.end, curve: Curves.easeOutCubic);
    final leave = Interval(exit.begin, exit.end, curve: Curves.easeInCubic);

    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final t = animation.value;
        final leaving = leave.transform(t);
        return Opacity(
          opacity: fadeIn.transform(t) * (1 - leaving),
          child: Transform.translate(
            offset: Offset(120 * leaving, 10 * (1 - rise.transform(t))),
            child: child,
          ),
        );
      },
    );
  }
}
