import 'package:flutter/material.dart';

import 'package:slate/theme/app_theme.dart';
import 'package:slate/widgets/common/entrance.dart';
import 'package:slate/widgets/home/balance_display.dart';
import 'package:slate/widgets/home/bank_card.dart';
import 'package:slate/widgets/home/home_top_bar.dart';

/// Black top section of the home: greeting, balance and card, each rising
/// in along the [intro] timeline.
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.intro,
    required this.userName,
    required this.balance,
    required this.horizontalPadding,
  });

  final AnimationController intro;
  final String userName;
  final int balance;
  final double horizontalPadding;

  static const _textRise = Offset(0, 14);

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;

    return Container(
      padding: EdgeInsets.fromLTRB(
        horizontalPadding,
        topInset + 9,
        horizontalPadding,
        23,
      ),
      decoration: const BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Entrance.timed(
            controller: intro,
            startMs: 50,
            offset: _textRise,
            child: HomeTopBar(userName: userName),
          ),
          const SizedBox(height: 27),
          Entrance.timed(
            controller: intro,
            startMs: 130,
            offset: _textRise,
            child: BalanceDisplay(
              balance: balance,
              progress: intro.drive(
                CurveTween(
                  curve: const Interval(0.02, 0.9, curve: Curves.easeOutExpo),
                ),
              ),
            ),
          ),
          const SizedBox(height: 17),
          Entrance.timed(
            controller: intro,
            startMs: 220,
            ms: 550,
            offset: const Offset(0, 50),
            child: BankCard(holder: userName),
          ),
        ],
      ),
    );
  }
}
