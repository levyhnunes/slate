import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:slate/models/transaction.dart';
import 'package:slate/widgets/common/entrance.dart';
import 'package:slate/widgets/home/section_header.dart';
import 'package:slate/widgets/home/transaction_tile.dart';

/// "Recent transactions" title and rows, as a sliver. The rows rise in one
/// after the other along the [intro] timeline.
class TransactionsSliver extends StatelessWidget {
  const TransactionsSliver({
    super.key,
    required this.intro,
    required this.transactions,
    required this.padding,
  });

  final AnimationController intro;
  final List<Transaction> transactions;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding,
      sliver: SliverList.list(
        children: [
          Entrance.timed(
            controller: intro,
            startMs: 450,
            offset: const Offset(0, 34),
            child: const SectionHeader(
              title: 'Recent transactions',
              action: 'See all',
            ),
          ),
          const SizedBox(height: 8),
          for (final (i, transaction) in transactions.indexed)
            Entrance.timed(
              controller: intro,
              // Rows past the fold are already settled when scrolled to.
              startMs: math.min(520 + i * 100, 1100),
              offset: const Offset(0, 40),
              child: TransactionTile(
                transaction: transaction,
                showDivider: i < transactions.length - 1,
              ),
            ),
        ],
      ),
    );
  }
}
