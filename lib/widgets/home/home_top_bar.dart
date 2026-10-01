import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:slate/widgets/home/circle_icon_button.dart';

/// Greeting on the left, search and add actions on the right.
class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Hello $userName',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              height: 1.25,
              fontWeight: FontWeight.w500,
              letterSpacing: -0.9,
            ),
          ),
        ),
        const CircleIconButton(icon: Iconsax.search_normal_copy),
        const SizedBox(width: 11),
        const CircleIconButton(icon: Iconsax.add_copy),
      ],
    );
  }
}
