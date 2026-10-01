import 'package:flutter/material.dart';

class ForgotPasswordLink extends StatelessWidget {
  const ForgotPasswordLink({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: const Text(
          'Forgot password?',
          style: TextStyle(
            fontSize: 14,
            height: 1.3,
            fontWeight: FontWeight.w500,
            letterSpacing: -0.4,
          ),
        ),
      ),
    );
  }
}
