import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:slate/widgets/login/login_brand.dart';
import 'package:slate/widgets/login/login_form.dart';
import 'package:slate/widgets/login/login_header_background.dart';
import 'package:slate/screens/home_screen.dart';

/// Fraction of the screen height reached by the black curved header.
const _headerFactor = 0.295;

/// How long the fake login request keeps the loader on screen.
const _requestDuration = Duration(milliseconds: 1450);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  // Intro: the black splash drains into the header, the brand slides in
  // from the left, then the form rises in item by item.
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1900),
  )..forward();

  late final Animation<double> _reveal = _intro.drive(
    CurveTween(curve: const Interval(0, 0.42, curve: Curves.easeOutCubic)),
  );

  // Exit: after a successful login the header floods the screen again.
  late final AnimationController _exit = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  );

  late final Animation<double> _flood = _exit.drive(
    CurveTween(curve: Curves.easeInOut),
  );

  @override
  void dispose() {
    _intro.dispose();
    _exit.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_loading) return;
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);
    await Future.delayed(_requestDuration);
    if (!mounted) return;
    await _exit.forward();
    // Hold on black for a beat before the home screen fades in.
    await Future.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, _, _) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = MediaQuery.sizeOf(context).height * _headerFactor;
    final topInset = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            // The form drifts up a little while the header floods over it.
            AnimatedBuilder(
              animation: _flood,
              builder: (context, child) => Transform.translate(
                offset: Offset(0, -18 * _flood.value),
                child: child,
              ),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: headerHeight)),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: LoginForm(
                      formKey: _formKey,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      intro: _intro,
                      loading: _loading,
                      onSubmit: _submit,
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              child: LoginHeaderBackground(
                headerHeight: headerHeight,
                reveal: _reveal,
                flood: _flood,
              ),
            ),
            Positioned(
              left: LoginForm.horizontalPadding,
              top: topInset + 33,
              child: LoginBrand(intro: _intro, exit: _exit),
            ),
          ],
        ),
      ),
    );
  }
}
