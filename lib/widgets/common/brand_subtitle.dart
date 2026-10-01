import 'package:flutter/material.dart';

/// The dim line of text shown under the brand title.
class BrandSubtitle extends StatelessWidget {
  const BrandSubtitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF8E8E8E),
        fontSize: 14,
        height: 1.3,
      ),
    );
  }
}
