import 'package:flutter/material.dart';

import 'package:slate/theme/app_theme.dart';
import 'package:slate/utils/not_implemented.dart';
import 'package:slate/widgets/common/entrance.dart';
import 'package:slate/widgets/login/google_logo.dart';
import 'package:slate/widgets/login/social_button.dart';

/// Facebook, Google and Apple buttons, popping in one after the other from
/// [startMs] of the [intro] timeline.
class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key, required this.intro, required this.startMs});

  final AnimationController intro;
  final int startMs;

  static const _stagger = 80;

  @override
  Widget build(BuildContext context) {
    final buttons = [
      SocialButton(
        onTap: () => showNotImplemented(context, 'Facebook login'),
        child: const Icon(Icons.facebook, color: Color(0xFF0866FF), size: 30),
      ),
      SocialButton(
        onTap: () => showNotImplemented(context, 'Google login'),
        child: const GoogleLogo(size: 23),
      ),
      SocialButton(
        onTap: () => showNotImplemented(context, 'Apple login'),
        child: const Icon(Icons.apple, color: AppColors.black, size: 29),
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 21,
      children: [
        for (final (i, button) in buttons.indexed)
          Entrance.timed(
            controller: intro,
            startMs: startMs + i * _stagger,
            offset: Offset.zero,
            beginScale: 0.5,
            child: button,
          ),
      ],
    );
  }
}
