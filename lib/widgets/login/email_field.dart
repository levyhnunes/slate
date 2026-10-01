import 'package:flutter/material.dart';

import 'package:slate/widgets/login/login_field_style.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key, required this.controller});

  final TextEditingController controller;

  static final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: loginFieldStyle,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      autocorrect: false,
      decoration: const InputDecoration(hintText: 'Enter your email'),
      validator: (value) {
        final email = value?.trim() ?? '';
        if (email.isEmpty) return 'Enter your email';
        if (!_emailPattern.hasMatch(email)) return 'Enter a valid email';
        return null;
      },
    );
  }
}
