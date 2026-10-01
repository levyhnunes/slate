import 'package:flutter/material.dart';

/// The "SLATE" wordmark, shared by the splash and the login header.
class BrandTitle extends StatelessWidget {
  const BrandTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'SLATE',
      style: TextStyle(
        color: Colors.white,
        fontSize: 30,
        height: 1.2,
        fontWeight: FontWeight.w500,
        letterSpacing: 8,
      ),
    );
  }
}
