import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:slate/theme/app_theme.dart';
import 'package:slate/widgets/common/brand_subtitle.dart';
import 'package:slate/widgets/common/brand_title.dart';
import 'package:slate/widgets/splash/splash_text_transition.dart';
import 'package:slate/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // Timeline: wait, rise in (title, then subtitle), hold, then both slide
  // out to the right (title first) before the login takes over.
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2800),
  );

  static const _titleIn = Interval(0.18, 0.34);
  static const _subtitleIn = Interval(0.24, 0.40);
  static const _titleOut = Interval(0.85, 0.96);
  static const _subtitleOut = Interval(0.89, 1.0);

  @override
  void initState() {
    super.initState();
    _controller.forward().whenComplete(_goToLogin);
  }

  void _goToLogin() {
    if (!mounted) return;
    // No route transition: the login starts fully black and reveals itself.
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: Duration.zero,
        pageBuilder: (_, _, _) => const LoginScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SplashTextTransition(
                animation: _controller,
                enter: _titleIn,
                exit: _titleOut,
                child: const BrandTitle(),
              ),
              const SizedBox(height: 14),
              SplashTextTransition(
                animation: _controller,
                enter: _subtitleIn,
                exit: _subtitleOut,
                child: const BrandSubtitle('All your cards in one place'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
