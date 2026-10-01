import 'package:flutter/material.dart';

import 'package:slate/widgets/common/brand_subtitle.dart';
import 'package:slate/widgets/common/brand_title.dart';
import 'package:slate/widgets/common/entrance.dart';

/// Brand title and welcome line of the login header. They slide in from the
/// left during [intro] and fade away during [exit].
class LoginBrand extends StatelessWidget {
  const LoginBrand({super.key, required this.intro, required this.exit});

  final Animation<double> intro;
  final Animation<double> exit;

  static const _slideFrom = Offset(-32, 0);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: FadeTransition(
        opacity: ReverseAnimation(exit),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Entrance(
              animation: intro,
              begin: 0.21,
              end: 0.47,
              offset: _slideFrom,
              child: const BrandTitle(),
            ),
            const SizedBox(height: 8),
            Entrance(
              animation: intro,
              begin: 0.25,
              end: 0.51,
              offset: _slideFrom,
              child: const BrandSubtitle('Welcome back! Log in to continue.'),
            ),
          ],
        ),
      ),
    );
  }
}
