import 'package:flutter/material.dart';

import 'package:slate/theme/app_theme.dart';
import 'package:slate/widgets/login/gooey_dots_loader.dart';

/// Full-width black pill that collapses into a short pill with a gooey
/// two-dot loader while [loading] is true.
class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.label,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final bool loading;
  final VoidCallback onPressed;

  static const height = 57.0;
  static const _loadingWidth = 132.0;

  @override
  Widget build(BuildContext context) {
    // Not a LayoutBuilder: the form sits in a SliverFillRemaining, which
    // needs intrinsic heights.
    return SizedBox(
      height: height,
      child: TweenAnimationBuilder<double>(
        tween: Tween(end: loading ? 1 : 0),
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
        builder: (context, collapse, child) => CustomSingleChildLayout(
          delegate: _CollapseDelegate(collapse),
          child: child,
        ),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: loading ? null : onPressed,
          child: DecoratedBox(
            decoration: const ShapeDecoration(
              color: AppColors.black,
              shape: StadiumBorder(),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedOpacity(
                  opacity: loading ? 0 : 1,
                  duration: const Duration(milliseconds: 120),
                  child: Text(
                    label,
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: loading ? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: GooeyDotsLoader(
                    active: loading,
                    size: const Size(_loadingWidth, height),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Centers the child, narrowing it from the full width (0) to the loading
/// pill (1).
class _CollapseDelegate extends SingleChildLayoutDelegate {
  const _CollapseDelegate(this.collapse);

  final double collapse;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final width =
        constraints.maxWidth +
        (LoginButton._loadingWidth - constraints.maxWidth) * collapse;
    return BoxConstraints.tightFor(width: width, height: constraints.maxHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) =>
      Offset((size.width - childSize.width) / 2, 0);

  @override
  bool shouldRelayout(_CollapseDelegate oldDelegate) =>
      oldDelegate.collapse != collapse;
}
