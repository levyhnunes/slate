import 'package:flutter/material.dart';

import 'package:slate/utils/not_implemented.dart';
import 'package:slate/widgets/common/entrance.dart';
import 'package:slate/widgets/login/email_field.dart';
import 'package:slate/widgets/login/field_label.dart';
import 'package:slate/widgets/login/forgot_password_link.dart';
import 'package:slate/widgets/login/login_button.dart';
import 'package:slate/widgets/login/or_divider.dart';
import 'package:slate/widgets/login/password_field.dart';
import 'package:slate/widgets/login/sign_up_prompt.dart';
import 'package:slate/widgets/login/social_login_row.dart';

/// The login form. Its items rise in one after the other along the [intro]
/// timeline.
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.intro,
    required this.loading,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final AnimationController intro;
  final bool loading;
  final VoidCallback onSubmit;

  static const horizontalPadding = 28.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        horizontalPadding,
        18,
        horizontalPadding,
        0,
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Entrance.timed(
              controller: intro,
              startMs: 650,
              child: const Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  height: 1.25,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -1.2,
                ),
              ),
            ),
            const SizedBox(height: 19),
            Entrance.timed(
              controller: intro,
              startMs: 715,
              child: const FieldLabel('Email'),
            ),
            const SizedBox(height: 8),
            Entrance.timed(
              controller: intro,
              startMs: 780,
              child: EmailField(controller: emailController),
            ),
            const SizedBox(height: 15),
            Entrance.timed(
              controller: intro,
              startMs: 845,
              child: const FieldLabel('Password'),
            ),
            const SizedBox(height: 8),
            Entrance.timed(
              controller: intro,
              startMs: 910,
              child: PasswordField(
                controller: passwordController,
                onSubmitted: onSubmit,
              ),
            ),
            const SizedBox(height: 14),
            Entrance.timed(
              controller: intro,
              startMs: 975,
              child: ForgotPasswordLink(
                onTap: () => showNotImplemented(context, 'Forgot password'),
              ),
            ),
            const SizedBox(height: 18),
            Entrance.timed(
              controller: intro,
              startMs: 1040,
              child: LoginButton(
                label: 'Login',
                loading: loading,
                onPressed: onSubmit,
              ),
            ),
            const SizedBox(height: 29),
            Entrance.timed(
              controller: intro,
              startMs: 1105,
              child: const OrDivider(),
            ),
            const SizedBox(height: 22),
            SocialLoginRow(intro: intro, startMs: 1150),
            const Spacer(),
            const SizedBox(height: 24),
            SafeArea(
              top: false,
              minimum: const EdgeInsets.only(bottom: 14),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Entrance.timed(
                  controller: intro,
                  startMs: 1250,
                  child: SignUpPrompt(
                    onSignUp: () => showNotImplemented(context, 'Sign up'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
