import 'package:flutter/material.dart';

import 'package:slate/theme/app_theme.dart';

/// Section title with a dim action label on the right.
class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 17,
            height: 1.3,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          action,
          style: const TextStyle(
            fontSize: 14,
            height: 1.3,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
