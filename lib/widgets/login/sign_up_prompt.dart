import 'package:flutter/material.dart';

import 'package:slate/theme/app_theme.dart';

/// "Don't have an account? Sign up" line at the bottom of the login.
class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key, required this.onSignUp});

  final VoidCallback onSignUp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?  ",
          style: TextStyle(
            fontSize: 14,
            height: 1.3,
            letterSpacing: -0.3,
            color: AppColors.textSecondary,
          ),
        ),
        GestureDetector(
          onTap: onSignUp,
          child: const Text(
            'Sign up',
            style: TextStyle(
              fontSize: 14,
              height: 1.3,
              fontWeight: FontWeight.w600,
              letterSpacing: -0.4,
            ),
          ),
        ),
      ],
    );
  }
}
