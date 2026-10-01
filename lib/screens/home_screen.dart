import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import 'package:slate/data/sample_account.dart';
import 'package:slate/theme/app_theme.dart';
import 'package:slate/widgets/common/entrance.dart';
import 'package:slate/widgets/home/bottom_nav.dart';
import 'package:slate/widgets/home/home_header.dart';
import 'package:slate/widgets/home/transactions_sliver.dart';

const _horizontalPadding = 26.0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // Intro, continuing from the black screen the login leaves behind: the
  // sheet fades in, the header texts and card rise, the balance counts up,
  // then the transactions and the nav bar come in.
  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..forward();

  late final Animation<double> _sheetFade = _intro.drive(
    CurveTween(curve: const Interval(0.03, 0.22, curve: Curves.easeOut)),
  );

  int _tab = 0;

  @override
  void dispose() {
    _intro.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
          children: [
            Positioned.fill(
              child: FadeTransition(
                opacity: _sheetFade,
                child: const ColoredBox(color: AppColors.surface),
              ),
            ),
            // Header and list scroll together so short screens don't overflow.
            CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: HomeHeader(
                    intro: _intro,
                    userName: sampleUserName,
                    balance: sampleBalance,
                    horizontalPadding: _horizontalPadding,
                  ),
                ),
                TransactionsSliver(
                  intro: _intro,
                  transactions: sampleTransactions,
                  padding: EdgeInsets.fromLTRB(
                    _horizontalPadding,
                    27,
                    _horizontalPadding,
                    bottomInset + BottomNav.height + 24,
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: math.max(bottomInset + 3, 20),
              child: Center(
                child: Entrance.timed(
                  controller: _intro,
                  startMs: 720,
                  ms: 380,
                  child: BottomNav(
                    index: _tab,
                    onChanged: (i) => setState(() => _tab = i),
                    icons: const [
                      Iconsax.home_2_copy,
                      Iconsax.arrow_swap_horizontal_copy,
                      Iconsax.card_copy,
                      Iconsax.user_copy,
                    ],
                    selectedIcons: const [
                      Iconsax.home_2,
                      Iconsax.arrow_swap_horizontal,
                      Iconsax.card,
                      Iconsax.user,
                    ],
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
