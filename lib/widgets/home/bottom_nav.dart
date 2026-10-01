import 'package:flutter/material.dart';

import 'package:slate/theme/app_theme.dart';

/// Floating black pill; the selected destination sits in a white circle
/// that slides between slots.
class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.icons,
    required this.selectedIcons,
    required this.index,
    required this.onChanged,
  });

  final List<IconData> icons;
  final List<IconData> selectedIcons;
  final int index;
  final ValueChanged<int> onChanged;

  static const height = 67.0;
  static const _slot = 59.5;
  static const _inset = 3.5;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.all(_inset),
      decoration: ShapeDecoration(
        color: const Color(0xFF0A0A0A),
        shape: const StadiumBorder(),
        shadows: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SizedBox(
        width: _slot * icons.length,
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 320),
              curve: Curves.easeOutCubic,
              left: _slot * index,
              top: 0,
              bottom: 0,
              width: _slot,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Row(
              children: [
                for (var i = 0; i < icons.length; i++)
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onChanged(i),
                    child: SizedBox(
                      width: _slot,
                      height: double.infinity,
                      child: Icon(
                        i == index ? selectedIcons[i] : icons[i],
                        size: 23,
                        color: i == index
                            ? AppColors.black
                            : const Color(0xFF9B9B9B),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
