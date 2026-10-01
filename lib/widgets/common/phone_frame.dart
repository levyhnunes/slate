import 'package:flutter/material.dart';

import 'package:slate/theme/app_theme.dart';

/// Keeps the app at phone width on wide viewports (web, tablets), centered
/// on a black backdrop. The layouts are designed for a phone.
class PhoneFrame extends StatelessWidget {
  const PhoneFrame({super.key, required this.child});

  final Widget child;

  static const _maxWidth = 480.0;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.black,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: _maxWidth),
          child: ClipRect(child: child),
        ),
      ),
    );
  }
}
