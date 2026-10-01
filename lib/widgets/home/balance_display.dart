import 'package:flutter/material.dart';

import 'package:slate/utils/formatters.dart';

/// "Available balance" caption and the amount, which counts up from zero to
/// [balance] as [progress] goes 0 → 1.
class BalanceDisplay extends StatelessWidget {
  const BalanceDisplay({
    super.key,
    required this.balance,
    required this.progress,
  });

  final int balance;
  final Animation<double> progress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Available balance',
          style: TextStyle(
            color: Color(0xFF7D7D7D),
            fontSize: 13,
            height: 1.25,
          ),
        ),
        const SizedBox(height: 4),
        AnimatedBuilder(
          animation: progress,
          builder: (context, _) => Text(
            '\$${groupThousands((balance * progress.value).round())}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              height: 1.2,
              fontWeight: FontWeight.w500,
              letterSpacing: -1.2,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
        ),
      ],
    );
  }
}
