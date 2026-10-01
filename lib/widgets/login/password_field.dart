import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:slate/theme/app_theme.dart';
import 'package:slate/widgets/login/login_field_style.dart';

/// Password input with a show/hide toggle.
class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    required this.controller,
    required this.onSubmitted,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: loginFieldStyle,
      obscureText: _obscure,
      textInputAction: TextInputAction.done,
      autofillHints: const [AutofillHints.password],
      onFieldSubmitted: (_) => widget.onSubmitted(),
      validator: (value) =>
          (value ?? '').isEmpty ? 'Enter your password' : null,
      decoration: InputDecoration(
        hintText: '••••••••',
        hintStyle: const TextStyle(color: AppColors.hint, letterSpacing: 1.5),
        suffixIconConstraints: const BoxConstraints.tightFor(
          width: 52,
          height: 52,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscure ? Iconsax.eye_slash_copy : Iconsax.eye_copy,
            color: AppColors.textSecondary,
            size: 20,
          ),
          onPressed: () => setState(() => _obscure = !_obscure),
        ),
      ),
    );
  }
}
